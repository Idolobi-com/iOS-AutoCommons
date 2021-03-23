//
//  ACCollectionViewCell.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 27/10/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

open class ACCollectionViewCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setLastView(view: UIView, constant: CGFloat = 16) {
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}

