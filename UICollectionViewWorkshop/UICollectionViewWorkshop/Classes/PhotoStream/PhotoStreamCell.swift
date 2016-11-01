//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class PhotoStreamCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    /*
     Without the following code subviews of the cell jump immediately to their new layout's frames.
     The solution is to simply force immediate layout of the cells subviews when the layout attributes are updated.

     Why does this work?
     When the collection view changes layouts, applyLayoutAttributes: is called for each cell as the collection
     view is setting up the animation block for that transition.
     But the layout of the cell's subviews is not done immediately - it is deferred to a later run loop -
     resulting in the actual subview layout changes not being incorporated into the animation block,
     so the subviews jump to their final positions immediately. Calling layoutIfNeeded means that we are telling
     the cell that we want the subview layout to happen immediately, so the layout is done within the animation block,
     and the subviews' frames are animated along with the cell itself.

     Reference: http://stackoverflow.com/a/23746693/4655732
 */

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }

}
