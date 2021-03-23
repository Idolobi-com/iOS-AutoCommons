//
//  ACFormatter.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 08/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation

public enum ACDateFormatType {
    case short, medium, long
    
    var format: String {
        switch self {
        case .short:
            return "dd MMM"
        case .medium:
            return "dd MMM yyyy"
        case .long:
            return "dd MMM yyyy, HH.mm"
        }
    }
}

open class ACFormatter {
    
    public static func formatPrice(_ price: Double?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        numberFormatter.decimalSeparator = ","
        let formattedNumber = numberFormatter.string(from: NSNumber(value: price ?? 0.0))
        return "\(formattedNumber ?? "")"
    }
    
    public static func formatLocalPrice(_ price: Double?) -> String {
        return "Rp\(formatPrice(price))"
    }
    
    public static func formatDate(_ unformattedDate: String, formatType: ACDateFormatType) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatterGet.date(from: unformattedDate)
        if let date = date {
            dateFormatterGet.locale = Locale(identifier: "id_ID")
            dateFormatterGet.dateFormat = formatType.format
            dateFormatterGet.timeZone = TimeZone.current
            return dateFormatterGet.string(from: date)
        }
        let index = unformattedDate.index(unformattedDate.startIndex, offsetBy: 10)
        return "\(unformattedDate[..<index])"
    }
    
    public static func getDateOf(_ unformattedDate: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatterGet.date(from: unformattedDate)
    }
    
    public static func getDateMilliSecond(date: Date) -> Int64 {
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    public static func getDateMilliSecond(_ unformattedDate: String) -> Int64 {
        return Int64((getDateOf(unformattedDate)?.timeIntervalSince1970 ?? 0) * 1000)
    }
    
    public static func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: date)
    }
    
}
