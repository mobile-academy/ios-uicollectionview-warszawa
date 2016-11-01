//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
@testable
import UICollectionViewWorkshop

class StreamItemDownloaderFake: ItemDownloading {
    var capturedCompletion: (([StreamItem]?, Error?) -> ())?
    var downloadItemsCalled : Bool = false

    func downloadItems(completion: @escaping ([StreamItem]?, Error?) -> ()) {
        capturedCompletion = completion
        downloadItemsCalled = true
    }
}
