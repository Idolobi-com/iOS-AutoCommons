//
//  UIColor+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class var green80: UIColor {
        return UIColor(rgb: 0x0F752E)
    }
    
    public class var green60: UIColor {
        return UIColor(rgb: 0x1C9440)
    }
    
    public class var green50: UIColor {
        return UIColor(rgb: 0x31B057)
    }
    
    public class var green40: UIColor {
        return UIColor(rgb: 0x51C273)
    }
    
    public class var green10: UIColor {
        return UIColor(rgb: 0xE1F7E8)
    }
    
    public class var red80: UIColor {
        return UIColor(rgb: 0xA1131A)
    }
    
    public class var red60: UIColor {
        return UIColor(rgb: 0xCF212A)
    }
    
    public class var red50: UIColor {
        return UIColor(rgb: 0xE52A34)
    }
    
    public class var red40: UIColor {
        return UIColor(rgb: 0xED646A)
    }
    
    public class var red10: UIColor {
        return UIColor(rgb: 0xFCE3E4)
    }
    
    public class var blue80: UIColor {
        return UIColor(rgb: 0x114D96)
    }
    
    public class var blue60: UIColor {
        return UIColor(rgb: 0x216BC4)
    }
    
    public class var blue50: UIColor {
        return UIColor(rgb: 0x388BF2)
    }
    
    public class var blue40: UIColor {
        return UIColor(rgb: 0x5BA0F5)
    }
    
    public class var blue10: UIColor {
        return UIColor(rgb: 0xDBEBFF)
    }
    
    public class var orange80: UIColor {
        return UIColor(rgb: 0xB85518)
    }
    
    public class var orange60: UIColor {
        return UIColor(rgb: 0xE6732C)
    }
    
    public class var orange50: UIColor {
        return UIColor(rgb: 0xFC8338)
    }
    
    public class var orange40: UIColor {
        return UIColor(rgb: 0xFF9A5C)
    }
    
    public class var orange10: UIColor {
        return UIColor(rgb: 0xFFE7D9)
    }
    
    public class var yellow80: UIColor {
        return UIColor(rgb: 0xC98C10)
    }
    
    public class var yellow60: UIColor {
        return UIColor(rgb: 0xE39E14)
    }
    
    public class var yellow50: UIColor {
        return UIColor(rgb: 0xFBAF18)
    }
    
    public class var yellow40: UIColor {
        return UIColor(rgb: 0xFCC047)
    }
    
    public class var yellow10: UIColor {
        return UIColor(rgb: 0xFFF0D1)
    }
    
    public class var black80: UIColor {
        return UIColor(rgb: 0x25282B)
    }
    
    public class var black60: UIColor {
        return UIColor(rgb: 0x52575C)
    }
    
    public class var black50: UIColor {
        return UIColor(rgb: 0xA0A4A8)
    }
    
    public class var black40: UIColor {
        return UIColor(rgb: 0xE8E8E8)
    }
    
    public class var black10: UIColor {
        return UIColor(rgb: 0xFAFAFA)
    }
    
}


extension UIColor {
    
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = String(hexString[start...])
        }
        let scanner = Scanner(string: hexString)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let redInt = Int(color >> 16) & mask
        let greenInt = Int(color >> 8) & mask
        let blueInt = Int(color) & mask
        let red   = CGFloat(redInt) / 255.0
        let green = CGFloat(greenInt) / 255.0
        let blue  = CGFloat(blueInt) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb: Int = (Int)(red * 255)<<16 | (Int)(green * 255)<<8 | (Int)(blue * 255)<<0
        return String(format: "#%06x", rgb)
    }
    
}
