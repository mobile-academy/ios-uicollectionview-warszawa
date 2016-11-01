//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import UICollectionViewWorkshop

class SourceTypeAvailabilityFake: SourceTypeAvailability {

    var fakeSources = [UIImagePickerControllerSourceType]()

    func availableSources() -> [UIImagePickerControllerSourceType] {
        return fakeSources
    }


}
