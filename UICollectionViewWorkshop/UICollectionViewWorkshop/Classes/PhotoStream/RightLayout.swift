//
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class RightLayout: ColumnVariantLayout {

    override func setupLayoutMetrics() {
        super.setupLayoutMetrics()
        sectionInset = UIEdgeInsets(top: 10.0, left: 200.0, bottom: 10.0, right: 10.0)
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        return shiftedAttributes(from: attributes)
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        return shiftedAttributes(from: attributes)
    }

    private func shiftedAttributes(from attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = attributes?.copy() as? UICollectionViewLayoutAttributes,
        let bounds = collectionView?.bounds else {
            return nil
        }
        var center = layoutAttributes.center
        center.x = bounds.width + CGFloat(itemSize.width) / 2.0
        layoutAttributes.center = center
        return layoutAttributes
    }

}
