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
        view.backgroundColor = .green
    }
    
    //MARK: UICollectionView Delegate & Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CarouselCollectionViewCell
        cell.textLabel.text = "\(indexPath.row)"
        return cell
    }
}
