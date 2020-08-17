//
//  CGFloat+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static var cornerSmall: CGFloat {
        return CGFloat(2)
    }
    
    static var cornerMedium: CGFloat {
        return CGFloat(4)
    }
    
    static var cornerLarge: CGFloat {
        return CGFloat(8)
    }
    
    static var cornerExtraLarge: CGFloat {
        return CGFloat(16)
    }
    
    static func cornerFull(size: CGFloat) -> CGFloat {
        return CGFloat(size / 2)
    }
    
}
