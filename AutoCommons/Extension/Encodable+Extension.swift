//
//  Encodable+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
//            Logger.d("<Encodable>.toDictionary(): JSONEncoder error")
            return [String: Any]()
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }!
    }
    
    func toJson() -> String? {
        var jsonString: String?
        do {
            let jsonData = try JSONEncoder().encode(self)
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
//            Logger.d("\(error.localizedDescription)")
        }
        return jsonString
    }
}
