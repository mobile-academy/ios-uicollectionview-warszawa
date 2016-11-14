//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class CalendarCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var separatorColor: UIColor?
    var separatorText: String?

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? CalendarCollectionViewLayoutAttributes else {
            return super.isEqual(object)
        }

        return super.isEqual(object) && other.separatorColor == separatorColor && other.separatorText == separatorText
    }

    override func copy() -> Any {
        let copiedObject = super.copy() as! CalendarCollectionViewLayoutAttributes
        copiedObject.separatorColor = separatorColor
        copiedObject.separatorText = separatorText
        return copiedObject
    }

    override var hash: Int {
        var baseHash = super.hash
        if let separatorColor = separatorColor {
            baseHash |= separatorColor.hash
        }
        
        if let separatorText = separatorText {
            baseHash |= separatorText.hash
        }
        
        return baseHash
    }
}
