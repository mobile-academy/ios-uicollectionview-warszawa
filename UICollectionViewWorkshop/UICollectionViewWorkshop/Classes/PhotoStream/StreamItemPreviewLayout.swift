//
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItemPreviewLayout: UICollectionViewLayout {

    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var itemSize = CGSize()

    override func prepare() {
        guard let collectionView = self.collectionView else {
            return
        }
        itemSize = collectionView.bounds.size
        layoutAttributes = []
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let center = collectionView.center;
        for i in 0..<numberOfItems {
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.center = center
            attributes.size = itemSize
            layoutAttributes.append(attributes)
        }
    }

    override func layoutAttributesForElements(`in` rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        layoutAttributes = []
    }

    override var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }
}
