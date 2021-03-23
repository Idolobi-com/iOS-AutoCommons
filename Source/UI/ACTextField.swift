//
//  ACTextField.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACTextField: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public let labelTitle: ACLabel = {
        return acLayout.label(id: "title", style: .headline, text: "", color: .black60)
    }()
    
    public lazy var textField: ACRoseTextField = {
        return ACRoseTextField(style: .border)
    }()
    
    var title: String? = nil
    
    let labelMessage: UILabel = {
        let label = UILabel(frame: .zero)
        label.accessibilityIdentifier = "acLabel_message"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red60
        let style = ACFontStyle.callout
        label.font = UIFont(name: style.font, size: style.size)
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = .byTruncatingTail
        label.text = ""
        label.isHidden = true
        return label
    }()
    
    init(style: ACRoseTextFieldStyle, title: String? = nil) {
        super.init(frame: .zero)
        self.title = title
        textField = ACRoseTextField(style: style)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        addSubview(labelTitle)
        addSubview(textField)
        addSubview(labelMessage)
        setupComponent()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponent() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.consLeading(view: stackView),
            labelTitle.consTrailing(view: stackView),
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            labelMessage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            labelMessage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(labelMessage)
        setTitle(title)
    }
    
    public func setTitle(_ title: String?) {
        if title != nil {
            stackView.insertArrangedSubview(labelTitle, at: 0)
        } else {
            stackView.removeArrangedSubview(labelTitle)
        }
        labelTitle.text = title
    }
    
    public func setOnError(message: String?) {
        let isError = message != nil
        labelMessage.isHidden = !isError
        textField.setOnError(isError: isError)
        if isError {
            stackView.addArrangedSubview(labelMessage)
        } else {
            stackView.removeArrangedSubview(labelMessage)
        }
        labelMessage.text = message
    }
}
