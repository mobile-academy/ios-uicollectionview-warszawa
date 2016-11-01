//
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class LeftLayout: ColumnVariantLayout {

    override func setupLayoutMetrics() {
        super.setupLayoutMetrics()
        sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 200.0)
    }

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)

        //TODO shift initial attributes so they are out of the screen on the right hand side

        return attributes
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)

        //TODO shift initial attributes so they are out of the screen on the right hand side

        return attributes
    }
}
