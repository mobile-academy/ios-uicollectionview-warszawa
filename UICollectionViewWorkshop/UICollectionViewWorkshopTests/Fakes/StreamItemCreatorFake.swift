//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import UICollectionViewWorkshop

class StreamItemCreatorFake: ItemCreating {

    weak var delegate: ItemCreatingDelegate?

    var createItemCalled = false

    func createStreamItem() {
        createItemCalled = true
    }

}
