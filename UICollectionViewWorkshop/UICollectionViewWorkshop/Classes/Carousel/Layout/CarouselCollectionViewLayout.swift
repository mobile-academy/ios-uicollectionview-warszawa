//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class CarouselCollectionViewLayout: UICollectionViewLayout {

    var itemSize: CGSize = CGSize(width: 280, height: 240) {
        didSet(value) {
            invalidateLayout()
        }
    }

    var interItemSpacing: CGFloat = 20 {
        didSet(value) {
            invalidateLayout()
        }
    }

    private var topBottomMargin: CGFloat = 0
    private var leftRightMargin: CGFloat = 0

    override func prepare() {
        super.prepare()

        let collectionViewSize = collectionView!.bounds.size
        leftRightMargin = (collectionViewSize.width - itemSize.width) / 2
        topBottomMargin = (collectionViewSize.height - itemSize.height) / 2
    }

    override var collectionViewContentSize: CGSize {
        let numberOfItems = CGFloat(collectionView!.numberOfItems(inSection: 0))

        let contentWidth = numberOfItems * itemSize.width + (numberOfItems - 1) * interItemSpacing + 2 * leftRightMargin
        let contentHeight = itemSize.height + 2 * topBottomMargin

        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let combinedItemWidth = itemSize.width + interItemSpacing
        let numberOfItems = collectionView!.numberOfItems(inSection: 0)

        let minimalXPosition = rect.minX - leftRightMargin
        let maximalXPosition = rect.maxX - leftRightMargin
        
        var firstVisibleItem = Int(floorf(Float(minimalXPosition / combinedItemWidth)))
        var lastVisibleItem = Int(ceilf(Float(maximalXPosition / combinedItemWidth)))

        if firstVisibleItem < 0 {
            firstVisibleItem = 0
        }
        
        if lastVisibleItem < 0 {
            lastVisibleItem = 0
        }

        if lastVisibleItem > numberOfItems {
            lastVisibleItem = numberOfItems
        }

        //TODO: Calculate position for visible cells

        return []
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

        //TODO: Calculate position for item at given index path

        return attributes
    }

    //MARK: Target Content Offset

    // Tip: this method is called when user lifts his finger - collection view asks us what should be the new content offset.
    // REMEMBER! You always have to follow velocity (aka if velocity is greater than 0 and current offset is 180 we *cannot*
    // go backwards (aka tell the system to stop at 150, for instance). Doing so will result in a graphical glitch.
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let attributes = layoutAttributes(forUserFingerMovingWithVelocity: velocity, proposedContentOffset: proposedContentOffset) else {
            return proposedContentOffset
        }
        
        let xPosition = attributes.center.x - collectionView!.bounds.width / 2        
        return CGPoint(x: xPosition, y: 0)
    }

    //Tip: this method is called when collection view bounds change - collection view asks us whether we'd like to adjust
    // content offset to adjust for new bounds
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        //TODO: Calculate the content offset that should be visible after rotation to keep our item centered
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }

    //MARK: Invalidation

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView!.bounds.size != newBounds.size
    }
}

fileprivate extension CarouselCollectionViewLayout {

    func layoutAttributes(forUserFingerMovingWithVelocity velocity: CGPoint, proposedContentOffset: CGPoint) -> UICollectionViewLayoutAttributes? {
        let nextVisibleBounds = CGRect(origin: proposedContentOffset, size: collectionView!.bounds.size)

        //TODO: Calculate which layout attributes should be selected as next centered layout attributes.
        //Tips: Use nextVisibleBounds calculated above! Make sure you also use velocity for determining direction (left, right or just dragging - all cases are important!)

        return nil
    }
}
