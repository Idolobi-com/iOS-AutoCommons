//
//  UILabel+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setHTMLFromString(htmlText: String, fontStyle: String = ACFontStyle.body.font, fontSize: CGFloat = ACFontStyle.body.size) {
        let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(fontStyle)'; font-size: \(fontSize)\">%@</span>", htmlText)
        do {
            let attrStr = try NSAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            
            self.attributedText = attrStr
        } catch {
            self.attributedText = NSAttributedString()
        }
    }
}
