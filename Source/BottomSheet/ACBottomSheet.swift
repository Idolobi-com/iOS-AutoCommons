//
//  ACBottomSheet.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 09/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACBottomSheet {

    public var viewDimming: UIView = {
        let view = acLayout.container(id: "dimming")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.alpha = 0
        return view
    }()
    
    private var parentVc: UIViewController?
    private var contentVc: UIViewController?
    private var callback: ((Int) -> Void)?
    public var bottomSheetVc = ACBottomSheetViewController()
    public var currentStateIndex = 1
    public var isDimmingViewEnabled = true
    public var states = [UIScreen.main.bounds.height,
                         UIScreen.main.bounds.height / 2, 92]
    
    public func show(parentVc: UIViewController, contentVc: UIViewController, stateIndex: Int = 1) {
        self.parentVc = parentVc
        self.contentVc = contentVc
        listenOnStateChanged()
        setupViewDimming()
        bottomSheetVc.states = states
        bottomSheetVc.currentStateIndex = stateIndex
        insertView(viewController: contentVc)
        parentVc.addChild(bottomSheetVc)
        parentVc.view.addSubview(bottomSheetVc.view)
        bottomSheetVc.didMove(toParent: parentVc)
    }
    
    private func setupViewDimming() {
        if isDimmingViewEnabled {
            guard let parentVc = parentVc else { return }
            parentVc.view.addSubview(viewDimming)
            viewDimming.frame = parentVc.view.frame
            UIView.animate(withDuration: 0.8) {
                self.viewDimming.alpha = 1
            }
        }
    }
    
    private func listenOnStateChanged() {
        bottomSheetVc.onStateChanged { (index) in
            self.currentStateIndex = index
            self.callback?(index)
            if self.isDimmingViewEnabled && index == 0 {
                UIView.animate(withDuration: 0.8, animations: {
                    self.viewDimming.alpha = 0
                }) { (_) in
                    self.viewDimming.removeFromSuperview()
                    self.bottomSheetVc.removeFromParent()
                    self.bottomSheetVc.view.removeFromSuperview()
                }
            }
        }
    }
    
    func onStateChanged(callback: @escaping ((Int) -> Void)) {
        self.callback = callback
    }
    
    private func insertView(viewController: UIViewController) {
        let viewToShow: UIView = viewController.view
        viewToShow.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetVc.viewContent.addSubview(viewToShow)
        NSLayoutConstraint.activate([
            viewToShow.topAnchor.constraint(equalTo: bottomSheetVc.viewContent.topAnchor),
            viewToShow.leadingAnchor.constraint(equalTo: bottomSheetVc.viewContent.leadingAnchor),
            viewToShow.trailingAnchor.constraint(equalTo: bottomSheetVc.viewContent.trailingAnchor),
            viewToShow.consBottomSafeArea(view: bottomSheetVc.viewContent)
        ])
    }
    
    public func setViewHandler(viewHandler: UIView) {
        bottomSheetVc.setViewHandler(viewHandler: viewHandler)
    }
    
}
