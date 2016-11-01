//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class HandView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
