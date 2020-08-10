//
//  RoseTextField.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public enum RoseTextFieldStyle {
    case bottomLine, border, spinner
}

public class RoseTextField: UITextField {
    
    private lazy var viewBorderBottom: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black40
        return view
    }()
    
    private var padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    private var textFieldStyle: RoseTextFieldStyle = .bottomLine
    
    init(style: RoseTextFieldStyle) {
        super.init(frame: .zero)
        textFieldStyle = style
        autocorrectionType = .no
        switch style {
        case .border:
            let color = UIColor.black40.withAlphaComponent(0.75)
            backgroundColor = color
            layer.cornerRadius = 6
            layer.borderWidth = 1.0
            layer.borderColor = color.cgColor
            padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            
        case .bottomLine:
            addSubview(viewBorderBottom)
            NSLayoutConstraint.activate([
                viewBorderBottom.topAnchor.constraint(equalTo: bottomAnchor),
                viewBorderBottom.leadingAnchor.constraint(equalTo: leadingAnchor),
                viewBorderBottom.trailingAnchor.constraint(equalTo: trailingAnchor),
                viewBorderBottom.heightAnchor.constraint(equalToConstant: 1)
                ])
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        case .spinner:
            backgroundColor = .white
            layer.cornerRadius = 6
            layer.borderWidth = 0.5
            layer.borderColor = UIColor.black.cgColor
            padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
    func setOnError(isError: Bool) {
        switch textFieldStyle {
        case .bottomLine:
            if isError {
                viewBorderBottom.backgroundColor = .red60
            } else {
                viewBorderBottom.backgroundColor = .black40
            }
        case .border:
            if isError {
                layer.borderColor = UIColor.red60.cgColor
            } else {
                layer.borderColor = UIColor.black40.cgColor
            }
        case .spinner:
            if isError {
                layer.borderColor = UIColor.red60.cgColor
            } else {
                layer.borderColor = UIColor.black.cgColor
            }
        }
        
    }
    
    func setLeftImage(image: UIImage?) {
        let iconPadding = 16
        let size = 24
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+(iconPadding*2), height: size) )
        let iconView = UIImageView(frame: CGRect(x: iconPadding, y: 0, width: size, height: size))
        iconView.image = image
        outerView.addSubview(iconView)
        leftView = outerView
        leftViewMode = .always
        padding = UIEdgeInsets(top: 8, left: 56, bottom: 8, right: 16)
        setNeedsLayout()
    }
    
    func changePlaceholderColor(placeHolder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
