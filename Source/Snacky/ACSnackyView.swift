//
//  ACSnackyView.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 14/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

internal let snackyRemoval: Notification.Name = Notification.Name(rawValue: "com.Idolobi.AutoCommons.ACSnacky.removalNotification")

open class ACSnackyView: UIView {
    
    internal var controller: ACSnacky?
    internal let defaultOpacity: Float = 0.98
    
    open lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: UIFont.systemFontSize)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    open lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: UIFont.systemFontSize)
        button.setTitleColor(.yellow, for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    open lazy var separator: UIView = {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.isAccessibilityElement = false
        separator.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        separator.layer.cornerRadius = 2.0
        return separator
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponent()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent() {
        backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1.00)
        layer.opacity = defaultOpacity
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.4
        layer.cornerRadius = 6.0
    }
    
    public func constructView(isNeedButton: Bool) {
        if isNeedButton {
            addSubview(titleLabel)
            addSubview(button)
            addSubview(separator)
            setupConstraintWithButton()
        } else {
            addSubview(titleLabel)
            setupConstraintWithoutButton()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRotate(notification:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func didRotate(notification: Notification) {
        DispatchQueue.main.async {
            self.frame = self.controller?.frameForView() ?? .zero
        }
    }
        
    @objc private func buttonTapped(sender: UIButton) {
        controller?.viewButtonTapped()
    }
    
    private func setupConstraintWithButton() {
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            button.consCenterY(view: self),
            button.consTrailing(view: self, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            separator.consCenterY(view: self),
            separator.consHeight(view: self, multiplier: 0.8),
            separator.consWidth(constant: 1.5),
            separator.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.consCenterY(view: self),
            titleLabel.consLeading(view: self, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: separator.leadingAnchor, constant: -8)
        ])
        titleLabel.textAlignment = .left
    }
    
    private func setupConstraintWithoutButton() {
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            titleLabel.consCenterY(view: self),
            titleLabel.consLeading(view: self, constant: 8),
            titleLabel.consTrailing(view: self, constant: -8)
        ])
        
        titleLabel.textAlignment = .center
    }
    
}
