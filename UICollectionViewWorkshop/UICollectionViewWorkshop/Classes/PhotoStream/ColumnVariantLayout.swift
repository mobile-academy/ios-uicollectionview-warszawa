//
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class ColumnVariantLayout: UICollectionViewFlowLayout {
    var numberOfColumns = 1
    var rowHeight = 100.0

    override init() {
        super.init()
        setupLayoutMetrics()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayoutMetrics()
    }

    func setupLayoutMetrics() {
        sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        minimumLineSpacing = 10.0
        minimumInteritemSpacing = 10.0
    }

    override func prepare() {
        itemSize = calculateItemSize()
        super.prepare()
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }

    private func calculateItemSize() -> CGSize {
        guard numberOfColumns > 0 else {
            return CGSize()
        }
        let availableRect = UIEdgeInsetsInsetRect(collectionView!.bounds, sectionInset)
        let widthForItems = availableRect.width - CGFloat((numberOfColumns - 1)) * minimumInteritemSpacing
        let itemWidth = floorf(Float(widthForItems) / Float(numberOfColumns))
        return CGSize(width: Double(itemWidth), height: rowHeight);
    }
}
