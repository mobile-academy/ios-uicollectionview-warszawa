//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class CalendarViewController: UICollectionViewController {
    
    let eventsProvider = EventsProvider(displayedDate: Date())
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        title = "Calendar"
        tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "Clock"), tag: 2)
    }
    
    
}
