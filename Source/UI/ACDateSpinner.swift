//
//  ACDateSpinner.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 12/12/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACDateSpinner: UIView {
    
    public var containerTextField: ACTextField = {
        return acLayout.textfield(id: "spinner", style: .spinner)
    }()
    
    public let pickerView: ACDatePickerView = {
        return acLayout.datePickerView(id: "spinner")
    }()
    
    public var dateChangedListener: (() -> Void)?
    
    init(style: ACRoseTextFieldStyle, delegate: UIPickerViewDelegate & UIPickerViewDataSource & UITextFieldDelegate) {
        super.init(frame: .zero)
        containerTextField = acLayout.textfield(id: "spinner", style: style)
        setupComponent()
        setupConstraint()
        containerTextField.textField.delegate = delegate
        containerTextField.textField.inputView = pickerView
        containerTextField.textField.tintColor = .clear
        pickerView.addTarget(self, action: #selector(onDateChangedListener), for: .valueChanged)
    }
    
    @objc func onDateChangedListener() {
        dateChangedListener?()
    }
    
    public func onDateChanged(callback: @escaping (() -> Void)) {
        dateChangedListener = callback
    }
    
    private func setupComponent() {
        addSubview(containerTextField)
    }
    
    public func setText(title: String) {
        containerTextField.textField.text = title
    }
    
    public func useToolBar(title: String) {
        containerTextField.textField.setInputAccessoryView(title: title)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            containerTextField.topAnchor.constraint(equalTo: topAnchor),
            containerTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: containerTextField.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
