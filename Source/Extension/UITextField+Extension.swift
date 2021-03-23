//
//  UITextField+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 30/10/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

extension UITextField {
    
    public func setInputAccessoryView(title: String) {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = acLayout.buttonText(id: "keyboardToolbar_\(title.lowercased())", title: title, fontStyle: .headline, color: .systemBlue)
        doneBtn.addTarget(self, action: #selector(UIView.endEditing(_:)), for: .touchUpInside)
        let doneButton = UIBarButtonItem(customView: doneBtn)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.layoutIfNeeded()
        inputAccessoryView = toolbar
    }
}
