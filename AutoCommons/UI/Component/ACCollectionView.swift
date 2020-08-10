//
//  ACCollectionView.swift
//  AutoCommons
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 06/08/20.
//  Copyright © 2020 Idolobi. All rights reserved.
//

import UIKit

public class ACCollectionView: UICollectionView {
    
}

public class ACCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader,
                                                    at: [originalAttributes.indexPath])
        context.invalidateSupplementaryElements(ofKind: UICollectionView.elementKindSectionFooter,
                                                    at: [originalAttributes.indexPath])
        return context
    }
}
