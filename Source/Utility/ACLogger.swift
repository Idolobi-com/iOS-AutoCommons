//
//  ACLogger.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 08/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation

class ACLogger {
    
    static var LOG_PREFIX = "ACLOG"
    
    static func d(_ message: String) {
        #if DEBUG
        print("\(LOG_PREFIX) D: \(message)")
        #endif
    }
    
    
    static func i(_ message: String) {
        print("\(LOG_PREFIX) I: \(message)")
    }
    
    static func e(_ message: String) {
        print("\(LOG_PREFIX) E: \(message)")
    }
}
