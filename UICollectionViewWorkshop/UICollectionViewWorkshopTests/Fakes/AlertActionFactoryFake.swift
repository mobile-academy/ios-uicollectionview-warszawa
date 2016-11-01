//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import UICollectionViewWorkshop

class AlertActionFactoryFake: AlertActionCreating {

    var capturedHandlers: [((UIAlertAction) -> ())]
    var capturedActions: [UIAlertAction]

    init() {
        capturedHandlers = []
        capturedActions = []
    }

    func createActionWithTitle(title: String, style: UIAlertActionStyle, handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        capturedHandlers.append(handler)
        capturedActions.append(action)
        return action
    }

}
