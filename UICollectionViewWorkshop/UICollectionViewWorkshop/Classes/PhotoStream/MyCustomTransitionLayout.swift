//
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class MyCustomTransitionLayout: UICollectionViewTransitionLayout {

    override func layoutAttributesForElements(`in` rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        for layoutAttributes in attributes! {
            rotate(attributes: layoutAttributes)
        }
        return attributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        rotate(attributes: attributes!)
        return attributes
    }

    private func rotate(attributes: UICollectionViewLayoutAttributes) {
        attributes.transform = CGAffineTransform(rotationAngle: transitionProgress * CGFloat(M_PI))
    }

}
