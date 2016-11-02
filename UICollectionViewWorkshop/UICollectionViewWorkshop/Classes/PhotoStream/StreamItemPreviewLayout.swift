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
            adjust(layoutAttributes: attributes, for: indexPath)
            layoutAttributes.append(attributes)
        }
    }

    override func layoutAttributesForElements(`in` rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.item]
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = layoutAttributes[itemIndexPath.item]
        if !isSelected(indexPath: itemIndexPath) {
            attributes.size = PhotoStreamLayout.streamItemSize
        }
        return attributes
    }


    override func invalidateLayout() {
        super.invalidateLayout()
        layoutAttributes = []
    }

    override var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }

    private func adjust(layoutAttributes: UICollectionViewLayoutAttributes, for indexPath: IndexPath) {
        if isSelected(indexPath: indexPath) {
            layoutAttributes.size = itemSize
            layoutAttributes.alpha = 1.0
        } else {
            layoutAttributes.size = CGSize()
            layoutAttributes.alpha = 0.0
        }
    }

    private func isSelected(indexPath: IndexPath) -> Bool {
        guard let selectedPaths = collectionView?.indexPathsForSelectedItems else {
            return false
        }
        for selectedIndexPath in selectedPaths {
            if indexPath == selectedIndexPath {
                return true
            }
        }
        return false
    }
}
