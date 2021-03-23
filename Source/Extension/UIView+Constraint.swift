//
//  UIView+Constraint.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 11/12/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor {}

public struct LayoutProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}

public class LayoutProxy {
    public lazy var widthAnchor = property(with: view.widthAnchor)
    public lazy var heightAnchor = property(with: view.heightAnchor)
    public lazy var topAnchor = property(with: view.topAnchor)
    public lazy var bottomAnchor = property(with: view.bottomAnchor)
    public lazy var topSafeAnchor = property(with: view.topAnchor)
    public lazy var bottomSafeAnchor = property(with: view.bottomAnchor)
    public lazy var leftAnchor = property(with: view.leftAnchor)
    public lazy var rightAnchor = property(with: view.rightAnchor)
    public lazy var leadingAnchor = property(with: view.leadingAnchor)
    public lazy var trailingAnchor = property(with: view.trailingAnchor)
    public lazy var centerYAnchor = property(with: view.centerYAnchor)
    public lazy var centerXAnchor = property(with: view.centerXAnchor)
    
    private let view: UIView

    fileprivate init(view: UIView) {
        self.view = view
        
        if #available(iOS 11.0, *) {
            topSafeAnchor = property(with: view.safeAreaLayoutGuide.topAnchor)
            bottomSafeAnchor = property(with: view.safeAreaLayoutGuide.bottomAnchor)
        }
    }

    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }
}

public extension LayoutProperty {
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(equalTo: otherAnchor, constant: constant).isActive = true
    }

    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }

    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) {
        anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant).isActive = true
    }
}

public extension UIView {
    
    func topSafeAnchor() -> NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    func bottomSafeAnchor() -> NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
    
    func setConstraint(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
    
    func centerXEdgeOf(_ v: UIView!, by spacing: CGFloat = 0.0) {
        self.setConstraint { constraints in
            constraints.centerXAnchor == v.centerXAnchor + spacing
        }
    }
    
    func centerYEdgeOf(_ v: UIView!, by spacing: CGFloat = 0.0) {
        self.setConstraint { constraints in
            constraints.centerYAnchor == v.centerYAnchor + spacing
        }
    }
    
    func centerXandYEdgeOf(_ v: UIView!, by spacing: CGFloat = 0.0) {
        self.centerXEdgeOf(v, by: spacing)
        self.centerYEdgeOf(v, by: spacing)
    }
}

/// DSL operator to add constant to anchor
/// - Returns: Given anchor and constant
public func +<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

/// DSL operator to subtract constant to anchor
/// - Returns: Given anchor and minus constant
public func -<A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

/// DSL operator to matching anchor by  equal with given constant: CGFloat
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  equal
public func ==<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.equal(to: rhs)
}

/// DSL operator to matching anchor by  equal with given constant: CGFloat
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  greaterThanOrEqual
public func >=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.greaterThanOrEqual(to: rhs)
}

/// DSL operator to matching anchor by  equal with given constant: CGFloat
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) {
    lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

/// DSL operator to matching anchor by  lessThanOrEqual
public func <=<A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) {
    lhs.lessThanOrEqual(to: rhs)
}
