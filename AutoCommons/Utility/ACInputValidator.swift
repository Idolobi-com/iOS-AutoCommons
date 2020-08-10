//
//  ACInputValidator.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 08/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

enum ACInputType {
    case alphabetWhiteSpace, phoneNumber, number, email, text
}

protocol ACInputValidatorCallback: class {
    func onInputValidatorUpdate(textField: UITextField, errorMessage: String?)
}

class ACInputValidator {
    
    private weak var delegate: ACInputValidatorCallback?
    private var textFields: [UITextField] = []
    private var isAllValid: [Bool] = []
    
    init(delegate: ACInputValidatorCallback?) {
        self.delegate = delegate
    }
    
    func whenValid(textField: UITextField, type: ACInputType, bypassLog: Bool = false) -> String {
        let text = textField.text ?? ""
        let isValid = isInputValid(input: text, type: type)
        
        textFields.append(textField)
        isAllValid.append(isValid)
        
        if delegate != nil && !bypassLog {
            let message: String? = isValid ? nil : getErrorMessage(type: type)
            delegate?.onInputValidatorUpdate(textField: textField, errorMessage: message)
        }
        
        return text
    }
    
    func runValidator(completion: @escaping (Bool) -> Void) {
        completion(!isAllValid.contains(false))
        clearCache()
    }
    
    func clearCache() {
        isAllValid = []
        textFields = []
    }
    
    private func getErrorMessage(type: ACInputType) -> String {
        switch type {
        case .alphabetWhiteSpace:
            return "Data tidak valid"
        case .phoneNumber:
            return "Nomor HP tidak valid"
        case .number:
            return "Nomor tidak valid"
        case .email:
            return "Email tidak valid"
        default:
            return "Data tidak valid"
        }
    }
    
    private func isInputValid(input: String?, type: ACInputType) -> Bool {
        switch type {
        case .alphabetWhiteSpace:
            return isTextValid(input: input ?? "")
        case .phoneNumber:
            return isPhoneNumberValid(input: input ?? "")
        case .number:
            return isDigitValid(input: input ?? "")
        case .email:
            return isEmailValid(input: input ?? "")
        default:
            return isTextValid(input: input ?? "")
        }
    }
    
    func isPhoneNumberValid(input: String) -> Bool {
        let pattern = "^(^\\+?628|^08)(\\d{6,})"
        return isMatch(input: input, pattern: pattern)
    }
    
    func isTextValid(input: String) -> Bool {
        let str = input.trim()
        return str != ""
    }
    
    func isDigitValid(input: String) -> Bool {
        let pattern = "\\d+"
        return isMatch(input: input, pattern: pattern)
    }
    
    func isEmailValid(input: String) -> Bool {
        // swiftlint:disable line_length
        let pattern = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
        return isMatch(input: input, pattern: pattern)
    }
    
    private func isMatch(input: String, pattern: String) -> Bool {
        if input.trim() == "" { return false }
        do {
            let range = NSRange(location: 0, length: input.utf16.count)
            let regex = try NSRegularExpression(pattern: pattern)
            let result = regex.firstMatch(in: input, options: [], range: range)
            let actualLength = range.length
            let firstMatchLength = result?.range.length ?? 0
            return actualLength == firstMatchLength
        } catch {
            ACLogger.d("Illegal regular expression: \(pattern).")
            return false
        }
    }
}
