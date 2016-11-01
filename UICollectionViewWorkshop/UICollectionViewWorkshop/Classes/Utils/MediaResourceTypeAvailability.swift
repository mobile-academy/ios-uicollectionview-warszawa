//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol SourceTypeAvailability {
    func availableSources() -> [UIImagePickerControllerSourceType]
}

class DefaultSourceTypeProvider: SourceTypeAvailability {

    //MARK: Public methods

    func availableSources() -> [UIImagePickerControllerSourceType] {
        var availableTypes = [UIImagePickerControllerSourceType]()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            availableTypes.append(.photoLibrary)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            availableTypes.append(.camera)
        }
        return availableTypes
    }
}
