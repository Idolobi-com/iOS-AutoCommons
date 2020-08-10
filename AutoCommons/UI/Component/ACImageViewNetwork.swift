//
//  ACImageViewNetwork.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

public class ACImageViewNetwork: UIImageView {
    
    var imageUrlString: String?
    
    public func loadImageUsingUrlString(_ urlString: String?, completion: @escaping (Bool) -> Void,
                                        contentMode: ContentMode = .scaleAspectFill) {
        guard let urlString = urlString else { return }
        
        if urlString == "" { return }
        
        imageUrlString = urlString
        
        let imageUrl = URL(string: urlString)
        
        guard let url = imageUrl else { return }
        if !urlString.contains("http") { return }
        
        self.contentMode = contentMode
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            self.contentMode = contentMode
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            if error != nil {
                return
            }
            
            if urlString.contains("http") {
                DispatchQueue.main.async(execute: {
                    if let data = data, let imageToCache = UIImage(data: data) {
                        
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        
                        self.contentMode = contentMode
                        self.clipsToBounds = true
                        imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
                
            }
        }).resume()
    }
}
