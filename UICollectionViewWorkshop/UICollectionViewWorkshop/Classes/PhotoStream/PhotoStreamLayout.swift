//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoStreamLayout: UICollectionViewFlowLayout {

    static let streamItemSize = CGSize(width: 90.0, height: 90.0)

    var presentedIndexPath: IndexPath?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sectionInset = UIEdgeInsets(top:10.0, left: 0.0, bottom:10.0, right:0.0)
        minimumInteritemSpacing = 5.0
        minimumLineSpacing = 5.0
        itemSize = PhotoStreamLayout.streamItemSize
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)

        if let presentedPath = presentedIndexPath {
            if itemIndexPath == presentedPath {
                attributes!.size = collectionView!.bounds.size
            }
        }

        return attributes

    }

}
