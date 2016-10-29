//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class CarouselViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView?.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    //MARK: UICollectionView Delegate & Data Source
    
}
