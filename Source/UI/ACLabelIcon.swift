//
//  ACLabelIcon.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public struct LabelIconSize {
    let width: CGFloat
    let height: CGFloat
    let imagePadding: CGFloat
}

public enum LabelIconPosition {
    case left, right
}

public class LabelIcon: UIView {
    
    public var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.accessibilityIdentifier = "imageView_labelIcon"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public var label: UILabel = {
        let label = UILabel(frame: .zero)
        let style = ACFontStyle.callout
        label.accessibilityIdentifier = "label_labelIcon"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.text = ""
        return label
    }()
    
    init(image: UIImage?, text: String, size: LabelIconSize, position: LabelIconPosition = .left) {
        super.init(frame: .zero)
        icon.image = image
        label.text = text
        setupComponent()
        setupConstraint(size.width, size.height, size.imagePadding, position)
    }
    
    public func setLabelStyle(style: ACFontStyle, color: UIColor, align: NSTextAlignment = NSTextAlignment.left) {
        label.textColor = color
        label.font = UIFont(name: style.font, size: CGFloat(style.size))
        label.numberOfLines = 0
        label.textAlignment = align
        label.lineBreakMode = .byTruncatingTail
    }
    
    private func setupComponent() {
        addSubview(icon)
        addSubview(label)
    }
    
    private func setupConstraint(_ width: CGFloat, _ height: CGFloat, _ imagePadding: CGFloat, _ position: LabelIconPosition) {
        if position == .left {
            NSLayoutConstraint.activate([
                icon.leadingAnchor.constraint(equalTo: leadingAnchor),
                icon.widthAnchor.constraint(equalToConstant: width),
                icon.heightAnchor.constraint(equalToConstant: height),
                icon.topAnchor.constraint(equalTo: topAnchor),
                icon.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: imagePadding),
                label.topAnchor.constraint(equalTo: topAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                icon.trailingAnchor.constraint(equalTo: trailingAnchor),
                icon.widthAnchor.constraint(equalToConstant: width),
                icon.heightAnchor.constraint(equalToConstant: height),
                icon.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: leadingAnchor),
                label.centerYAnchor.constraint(equalTo: centerYAnchor),
                label.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -imagePadding)
                ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
