//
//  ACBottomSheetViewController.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 09/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACBottomSheetViewController: UIViewController {
    
    public let viewContainerHandler: UIView = {
        let view = acLayout.container(id: "containerHandler")
        view.backgroundColor = .white
        return view
    }()
    
    public let viewHandlerIcon: UIView = {
        let view = acLayout.container(id: "handlerIcon")
        view.backgroundColor = .black40
        return view
    }()
    
    public var viewContent: UIView = {
        let view = acLayout.container(id: "container")
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var viewHandling = self.viewContainerHandler
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var callback: ((Int) -> Void)?
    public var states: [CGFloat] = []
    public var currentStateIndex = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupConstraint()
        initialMove()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewContainerHandler.roundCorners(corners: [.topLeft, .topRight], radius: 16.0)
        viewHandlerIcon.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 4.0)
    }
    
    public func setViewHandler(viewHandler: UIView) {
        if let panGestureRecognizer = panGestureRecognizer {
            self.viewHandling.removeGestureRecognizer(panGestureRecognizer)
        }
        panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        self.viewHandling = viewHandler
        self.viewHandling.addGestureRecognizer(panGestureRecognizer!)
    }
    

    public func moveWithAnimation(stateIndex: Int) {
        UIView.animate(withDuration: 0.8, animations: {
            self.moveView(stateIndex: stateIndex)
        }, completion: nil)
    }
    
    public func onStateChanged(callback: @escaping ((Int) -> Void)) {
        self.callback = callback
    }
    
    private func setupComponent() {
        view.addSubview(viewContainerHandler)
        viewContainerHandler.addSubview(viewHandlerIcon)
        view.addSubview(viewContent)
        view.addShadow()
        setViewHandler(viewHandler: viewHandling)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            viewContainerHandler.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            viewContainerHandler.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewContainerHandler.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewContainerHandler.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            viewHandlerIcon.centerXAnchor.constraint(equalTo: viewContainerHandler.centerXAnchor),
            viewHandlerIcon.centerYAnchor.constraint(equalTo: viewContainerHandler.centerYAnchor),
            viewHandlerIcon.heightAnchor.constraint(equalToConstant: 8),
            viewHandlerIcon.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            viewContent.topAnchor.constraint(equalTo: viewContainerHandler.bottomAnchor),
            viewContent.leadingAnchor.constraint(equalTo: viewContainerHandler.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: viewContainerHandler.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func moveView(stateIndex: Int) {
        var index = 0
        if stateIndex >= states.count {
            index = states.count - 1
        } else if stateIndex < 0 {
            index = 0
        } else {
            index = stateIndex
        }
        let yPosition = states[index]
        moveView(yPosition: yPosition)
        currentStateIndex = index
        callback?(currentStateIndex)
    }
    
    private func moveView(yPosition: CGFloat) {
        let height = UIScreen.main.bounds.size.height - states[states.count-1]
        view.frame = CGRect(x: 0, y: yPosition, width: UIScreen.main.bounds.size.width, height: height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        
        if (minY + translation.y >= states[states.count - 1]) && (minY + translation.y <= states[0]) {
            moveView(yPosition: minY + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        if recognizer.state == .ended {
            moveWithAnimation(stateIndex: getNextState(recognizer: recognizer))
        }
    }
    
    private func getNextState(recognizer: UIPanGestureRecognizer) -> Int {
        let y = recognizer.velocity(in: self.view).y
        if y >= 0 {
            currentStateIndex -= 1
        } else {
            currentStateIndex += 1
        }
        return currentStateIndex
    }
    
    private func initialMove() {
        moveView(yPosition: view.frame.maxY)
        moveWithAnimation(stateIndex: currentStateIndex)
    }
    
}

fileprivate extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black50.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -4)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = Float(0.4)
    }
}
