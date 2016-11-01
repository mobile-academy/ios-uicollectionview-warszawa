//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import UICollectionViewWorkshop

class TestStreamItemCreatorDelegate: ItemCreatingDelegate {

    var capturedStreamItem: StreamItem?
    var capturedError: Error?
    
    var failedWithErrorCalled = false

    //MARK: ItemCreatingDelegate

    func creator(creator: ItemCreating, didCreateItem item: StreamItem) {
        capturedStreamItem = item
    }

    func creator(creator: ItemCreating, failedWithError error: Error) {
        capturedError = error
        failedWithErrorCalled = true
    }

}
