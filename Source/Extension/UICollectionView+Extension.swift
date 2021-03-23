//
//  UICollectionView+Extension.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 27/10/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func setAutomaticHeight() {
        if let flowLayout = collectionViewLayout as? ACCollectionViewFlowLayout {
            let width = UIScreen.main.bounds.size.width
            flowLayout.estimatedItemSize = CGSize(width: width, height: 10)
        }
    }
    
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
        }
        return cell
    }
}
