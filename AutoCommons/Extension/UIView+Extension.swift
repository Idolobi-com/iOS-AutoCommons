//
//  UIView+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 10/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

extension UIView {
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

extension UIView {
    
    public func consTopSafeArea(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            return self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
        } else {
            return self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        }
    }
    
    public func consBottomSafeArea(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            return self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
        } else {
            return self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        }
    }
    
    public func consLeading(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
    }
    
    public func consTrailing(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
    }
    
}

