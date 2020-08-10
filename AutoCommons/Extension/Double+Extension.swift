//
//  Double+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation

extension Double {
    
    var clean: String {
        let round = roundedDecimal(to: 1)
        return round.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", round) : String(round)
    }
    
    func roundedDecimal(to scale: Int) -> Double {
        let multiplier = pow(10, Double(scale))
        return Darwin.round(self * multiplier) / multiplier
    }
    
}
