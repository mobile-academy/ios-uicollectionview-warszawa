//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItemViewController: UICollectionViewController {
    
    var streamItem: StreamItem?
    var imageManipulator: ImageManipulating
    
    required init?(coder: NSCoder) {
        imageManipulator = DefaultImageManipulator()
        super.init(coder: coder)
    }
    
    
    
}
