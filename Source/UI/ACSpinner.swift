//
//  ACSpinner.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 29/10/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACSpinner: UIView {
    
    public var containerTextField: ACTextField = {
        return acLayout.textfield(id: "spinner", style: .spinner)
    }()
    
    public let pickerView: ACPickerView = {
        return acLayout.pickerView(id: "spinner")
    }()
    
    init(style: ACRoseTextFieldStyle, delegate: UIPickerViewDelegate & UIPickerViewDataSource & UITextFieldDelegate) {
        super.init(frame: .zero)
        containerTextField = acLayout.textfield(id: "spinner", style: style)
        setupComponent()
        setupConstraint()
        pickerView.dataSource = delegate
        pickerView.delegate = delegate
        containerTextField.textField.delegate = delegate
        containerTextField.textField.inputView = pickerView
        containerTextField.textField.tintColor = .clear
    }
    
    private func setupComponent() {
        addSubview(containerTextField)
    }
    
    public func setText(title: String) {
        containerTextField.textField.text = title
    }
    
    public func selectRow(row: Int, inComponent: Int = 0, animated: Bool = true) {
        pickerView.selectRow(row, inComponent: inComponent, animated: animated)
    }
    
    public func selectedRow(inComponent: Int = 0) -> Int {
        pickerView.selectedRow(inComponent: inComponent)
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
