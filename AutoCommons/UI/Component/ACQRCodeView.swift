//
//  ACQRCodeView.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 07/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACQRCodeView: UIView {
    lazy var filter = CIFilter(name: "CIQRCodeGenerator")
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    public func generateCode(_ string: String, foregroundColor: UIColor = .black, backgroundColor: UIColor = .white) {
        guard let filter = filter,
            let data = string.data(using: .isoLatin1, allowLossyConversion: false) else {
                return
        }
        
        filter.setValue(data, forKey: "inputMessage")
        
        guard let ciImage = filter.outputImage else {
            return
        }
        DispatchQueue.main.async {
            let transformed = ciImage.transformed(by: CGAffineTransform.init(scaleX: 10, y: 10))
            let invertFilter = CIFilter(name: "CIColorInvert")
            invertFilter?.setValue(transformed, forKey: kCIInputImageKey)
            
            let alphaFilter = CIFilter(name: "CIMaskToAlpha")
            alphaFilter?.setValue(invertFilter?.outputImage, forKey: kCIInputImageKey)
            
            if let outputImage = alphaFilter?.outputImage {
                self.imageView.tintColor = foregroundColor
                self.imageView.backgroundColor = backgroundColor
                self.imageView.image = UIImage(ciImage: outputImage, scale: 2.0, orientation: .up)
                    .withRenderingMode(.alwaysTemplate)
            }
        }
    }
}
