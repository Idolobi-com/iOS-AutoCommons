//
//  ACButton.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

open class ACButton: UIButton, ACButtonBehavior {
    
    public var performClick: (() -> Void)?
    var height = CGFloat(48)
    var defaultBgColor: UIColor?
    var defaultTitleColor: UIColor?
    var defaultBorderColor: UIColor?
    var buttonStyle = ACButtonStyle.fillNormal
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(onClickListener), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func onClick(callback: @escaping (() -> Void)) {
        performClick = callback
    }
    
    public func setDecoration(style: ACButtonStyle, titleColor: UIColor?, bgColor: UIColor? = nil, borderColor: UIColor? = nil) {
        let fontStyle = ACFontStyle.headline
        titleLabel?.font = UIFont(name: fontStyle.font, size: fontStyle.size)
        buttonStyle = style
        defaultTitleColor = titleColor
        defaultBgColor = bgColor
        defaultBorderColor = borderColor
        switch style {
        case .fillNormal, .fillSmall:
            self.setStyleFillNormal()
        case .ghostNormal, .ghostSmall:
            defaultBgColor = .white
            self.setStyleGhostNormal()
        case .nudeNormal, .nudeSmall, .plain:
            defaultBgColor = nil
            defaultBorderColor = nil
            self.setStyleNudeNormal()
        }
        if style.height != 0 {
            self.heightAnchor.constraint(equalToConstant: style.height).isActive = true
            self.layer.cornerRadius = .cornerLarge
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }
    
    public func setStyleFillNormal() {
        backgroundColor = defaultBgColor
        setTitleColor(defaultTitleColor, for: .normal)
    }
    
    public func setStyleFillDisable() {
        backgroundColor = .black40
        setTitleColor(.white, for: .normal)
    }
    
    public func setStyleGhostNormal() {
        backgroundColor = .white
        setTitleColor(defaultTitleColor, for: .normal)
        layer.borderColor = defaultBorderColor?.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1.0
    }
    
    public func setStyleGhostDisable() {
        backgroundColor = .black40
        setTitleColor(.black40, for: .normal)
    }
    
    public func setStyleNudeNormal() {
        setTitleColor(defaultTitleColor, for: .normal)
    }
    
    public func setStyleNudeDisable() {
        setTitleColor(.black40, for: .normal)
    }
    
    func withIcon(image: UIImage?, offset: CGFloat = 16, position: ContentHorizontalAlignment = .left) {
        self.setImage(image, for: .normal)
        if position == .left {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
        } else if position == .right {
            self.semanticContentAttribute = .forceRightToLeft
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: -offset)
        }
    }
    
    public func setEnabled(is enabled: Bool) {
        self.isEnabled = enabled
        if enabled {
            switch buttonStyle {
            case .fillNormal, .fillSmall:
                self.setStyleFillNormal()
            case .ghostNormal, .ghostSmall:
                self.setStyleGhostNormal()
            case .nudeNormal, .nudeSmall, .plain:
                self.setStyleNudeNormal()
            }
        } else {
            switch buttonStyle {
            case .fillNormal, .fillSmall:
                self.setStyleFillDisable()
            case .ghostNormal, .ghostSmall:
                self.setStyleGhostDisable()
            case .nudeNormal, .nudeSmall, .plain:
                self.setStyleNudeDisable()
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClickListener() {
        performClick?()
    }
}

protocol ACButtonBehavior {
    func onClick(callback: @escaping (() -> Void))
}

public enum ACButtonStyle {
    case fillNormal, ghostNormal, nudeNormal, fillSmall, ghostSmall, nudeSmall, plain
    
    var height: CGFloat {
        switch self {
        case .fillNormal, .ghostNormal, .nudeNormal:
            return CGFloat(48)
        case .fillSmall, .ghostSmall, .nudeSmall:
            return CGFloat(32)
        case .plain:
            return CGFloat(0)
        }
    }
}
