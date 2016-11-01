//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

@testable
import UICollectionViewWorkshop

class ParseAdapterFake: ParseAdapting {

    //MARK: Properties

    var capturedQuery: PFQuery<PFObject>?
    var capturedQueryCompletion: (([PFObject]?, Error?) -> ())?

    var capturedUploadedObject: PFObject?
    var capturedUploadCompletion: ((Bool, Error?) -> ())?

    //MARK: Overrides

    func executeQuery(query: PFQuery<PFObject>, completion: @escaping ([PFObject]?, Error?) -> ()) {
        capturedQuery = query
        capturedQueryCompletion = completion
    }

    func uploadObject(object: PFObject, completion: @escaping (Bool, Error?) -> ()) {
        capturedUploadedObject = object
        capturedUploadCompletion = completion
    }

}
