//
//  ACSnacky.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 14/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

open class ACSnacky: Equatable {
    
    open lazy var view: ACSnackyView = {
        let snackyView = ACSnackyView(frame: .zero)
        snackyView.controller = self
        snackyView.isHidden = true
        return snackyView
    }()
    
    open var widthPercent: CGFloat = 0.98 {
        didSet {
            if self.widthPercent < 0.0 || self.widthPercent > 1.0 {
                self.widthPercent = 0.98
            }
            self.view.setNeedsLayout()
        }
    }
    
    open var height: CGFloat = 40.0 {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    open var bottomSpacing: CGFloat = 12.0 {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    open var stackedBottomSpacing: CGFloat = 8.0 {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    public typealias SnackyCompletion = (Bool) -> Void
    open var adjustsPositionForSafeArea: Bool = true
    open var viewToDisplayIn: UIView?
    open var animationDuration: TimeInterval = 0.5
    private var displayTimer: Timer?
    private var wasAnimated: Bool = false
    private var completion: SnackyCompletion?
    private var isWithButton = false
    
    public init (title: String, buttonTitle: String?) {
        view.titleLabel.text = title
        if let bTitle = buttonTitle {
            isWithButton = true
            view.constructView(isNeedButton: true)
            view.button.setTitle(bTitle, for: .normal)
        } else {
            view.constructView(isNeedButton: false)
        }
        finishInit()
    }
    
    public init(attributedTitle: NSAttributedString, attributedButtonTitle: NSAttributedString?) {
        view.titleLabel.attributedText = attributedTitle
        
        if let bTitle = attributedButtonTitle {
            isWithButton = true
            view.constructView(isNeedButton: true)
            view.button.setAttributedTitle(bTitle, for: .normal)
        } else {
            view.constructView(isNeedButton: false)
        }
        finishInit()
    }
    
    private func finishInit() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        right.direction = .right
        let down = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        down.direction = .down
        view.addGestureRecognizer(left)
        view.addGestureRecognizer(right)
        view.addGestureRecognizer(down)
        NotificationCenter.default.addObserver(self, selector: #selector(self.snackyWasRemoved(notification:)), name: snackyRemoval, object: nil)
    }
    
    internal func frameForView() -> CGRect {
        guard let superview = viewToDisplayIn ?? UIApplication.shared.keyWindow ?? nil else {
            return .zero
        }
        let width: CGFloat = superview.bounds.width * widthPercent
        let startX: CGFloat = (superview.bounds.width - width) / 2.0
        let startY: CGFloat
        var snackyView: ACSnackyView?
        for sub in superview.subviews {
            if let snacky = sub as? ACSnackyView, snacky != view, snacky.frame.maxY > view.frame.maxY {
                snackyView = snacky
            }
        }
        let safeAreaInset: CGFloat
        if #available(iOS 11.0, *), self.adjustsPositionForSafeArea {
            safeAreaInset = superview.safeAreaInsets.bottom
        } else {
            safeAreaInset = 0
        }
        
        if let snacky = snackyView {
            startY = snacky.frame.maxY - snacky.frame.height - height - stackedBottomSpacing
        } else {
            startY = superview.bounds.maxY - height - bottomSpacing - safeAreaInset
        }
        
        return CGRect(x: startX, y: startY, width: width, height: height)
    }
    
    private func removeSnacky() {
        view.removeFromSuperview()
        displayTimer?.invalidate()
        displayTimer = nil
    }
    
    private func animateIn() {
        let frame = frameForView()
        let inY = frame.origin.y
        let outY = frame.origin.y + height + bottomSpacing
        view.isHidden = false
        view.layer.opacity = 0.0
        view.frame = CGRect(x: frame.origin.x, y: outY, width: frame.width, height: frame.height)
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.1,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.view.layer.opacity = self.view.defaultOpacity
                self.view.frame = CGRect(x: frame.origin.x, y: inY, width: frame.width, height: frame.height)
        },
            completion: nil
        )
        
        wasAnimated = true
    }
    
    private func animateOut(wasButtonTapped: Bool = false) {
        let frame = view.frame
        let outY = frame.origin.y + height + bottomSpacing
        let pos = CGPoint(x: frame.origin.x, y: outY)
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.view.frame = CGRect(origin: pos, size: frame.size)
                self.view.layer.opacity = 0.0
            }, completion: { _ in
                self.completion?(wasButtonTapped)
                self.removeSnacky()
            }
        )
    }
    
    private func animateSwipeOut(to position: CGPoint) {
        displayTimer?.invalidate()
        displayTimer = nil
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.view.frame = CGRect(origin: position, size: self.view.frame.size)
                self.view.layer.opacity = 0.1
            }, completion: { _ in
                self.completion?(false)
                self.removeSnacky()
            }
        )
    }
    
    @objc private func timerDidFinish() {
        if wasAnimated {
            self.animateOut()
        } else {
            completion?(false)
            self.removeSnacky()
        }
    }
    
    internal func viewButtonTapped() {
        displayTimer?.invalidate()
        displayTimer = nil
        if wasAnimated {
            self.animateOut(wasButtonTapped: true)
        } else {
            completion?(true)
            self.removeSnacky()
        }
    }
    
    @objc private func snackyWasRemoved(notification: Notification) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: .curveEaseOut,
            animations: {
                self.view.frame = self.frameForView()
        }, completion: nil)
    }
    
    @objc private func handleSwipes(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            let position = CGPoint(x: view.frame.origin.x - view.frame.width, y: view.frame.origin.y)
            animateSwipeOut(to: position)
        case .right:
            let position = CGPoint(x: view.frame.origin.x + view.frame.width, y: view.frame.origin.y)
            animateSwipeOut(to: position)
        case .down:
            let position = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + view.frame.height + bottomSpacing)
            animateSwipeOut(to: position)
        case .up:
            fallthrough
        default: break
        }
    }
    
    open func show(displayDuration: TimeInterval? = 5.0, animated: Bool = true, completion: SnackyCompletion? = nil) {
        guard let superview = viewToDisplayIn ?? UIApplication.shared.keyWindow ?? nil else {
            fatalError("Unable to get a superview, was not able to show\n Couldn't add ACSnackyView as a subview to the main UIWindow")
        }
        
        superview.addSubview(self.view)
        self.completion = completion
        
        if let duration = displayDuration {
            displayTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.timerDidFinish), userInfo: nil, repeats: false)
        }
        
        if animated {
            animateIn()
        } else {
            view.isHidden = false
        }
    }
    
    open func dismiss(animated: Bool = true, completeWithAction: Bool = false) {
        guard !completeWithAction else {
            self.viewButtonTapped()
            return
        }
        displayTimer?.invalidate()
        displayTimer = nil
        if animated {
            self.animateOut()
        } else {
            self.removeSnacky()
        }
    }
    
    public static func show(view: UIView? = nil, title: String, buttonTitle: String? = nil, displayDuration: TimeInterval? = 5.0, completion: SnackyCompletion? = nil) {
        let snacky = ACSnacky(title: title, buttonTitle: buttonTitle)
        snacky.viewToDisplayIn = view
        snacky.show(displayDuration: displayDuration, completion: completion)
    }
    
    public static func show(attributedTitle: NSAttributedString, displayDuration: TimeInterval? = 5.0, completion: SnackyCompletion? = nil) {
        let snacky = ACSnacky(attributedTitle: attributedTitle, attributedButtonTitle: nil)
        snacky.show(displayDuration: displayDuration, completion: completion)
    }
    
    public static func == (lhs: ACSnacky, rhs: ACSnacky) -> Bool {
        return lhs === rhs
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        displayTimer?.invalidate()
        displayTimer = nil
        view.controller = nil
        view.removeFromSuperview()
    }
}
