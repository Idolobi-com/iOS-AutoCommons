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
    
    public func asCardView(cornerRadius: CGFloat = 8.0, shadowRadius: CGFloat = 6.0, shadowOpacity: CGFloat = 0.4) {
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = Float(shadowOpacity)
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
    
    public func consTop(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
    }
    
    public func consBottom(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
    }
    
    public func consLeading(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
    }
    
    public func consTrailing(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
    }
    
    public func consCenterX(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
    }
    
    public func consCenterY(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        return self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
    }
    
    public func consHeight(constant: CGFloat) -> NSLayoutConstraint {
        return self.heightAnchor.constraint(equalToConstant: constant)
    }
    
    public func consHeight(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
    }
    
    public func consWidth(constant: CGFloat) -> NSLayoutConstraint {
        return self.widthAnchor.constraint(equalToConstant: constant)
    }
    
    public func consWidth(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
    }
    
}

