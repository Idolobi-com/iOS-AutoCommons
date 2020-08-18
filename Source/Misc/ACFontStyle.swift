//
//  ACFontStyle.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public enum ACFontStyle {
    case largeTitle, title1, title2, title3, headline, body, callout, subhead, footnote, caption1, caption2
    
    public var font: String {
        switch self {
        case .largeTitle, .title1, .title2, .title3, .headline:
            return "ArialRoundedMTBold"
        case .body, .callout, .subhead, .footnote, .caption1, .caption2:
            return "AppleSDGothicNeo-Regular"
        }
    }
    
    public var size: CGFloat {
        switch self {
        case .largeTitle:
            return 34
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .body:
            return 17
        case .callout:
            return 16
        case .subhead:
            return 16
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        }
    }
}
