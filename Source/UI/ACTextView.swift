//
//  ACTextView.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACTextView: UITextView, UITextViewDelegate {
    
    var placeHolder: String = ""
    
    convenience init(placeHolder: String) {
        self.init()
        self.placeHolder = placeHolder
        self.text = placeHolder
        if placeHolder == "" {
            self.textColor = UIColor.black
        } else {
            self.textColor = UIColor.black40
        }
        delegate = self
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.black40 {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trim() == "" {
            textView.text = placeHolder
            textView.textColor = UIColor.black40
        }
    }
    
}
