//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class CalendarViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        title = "Calendar"
        tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "Clock"), tag: 2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Sadly, this is required...")
    }
    
}
