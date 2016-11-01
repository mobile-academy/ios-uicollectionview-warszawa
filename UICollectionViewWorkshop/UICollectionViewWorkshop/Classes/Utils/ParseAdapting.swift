//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import Parse

protocol ParseAdapting {
    func executeQuery(query: PFQuery<PFObject>, completion: @escaping ([PFObject]?, Error?) -> ())
    func uploadObject(object: PFObject, completion: @escaping (Bool, Error?) -> ())
}

class DefaultParseAdapter: ParseAdapting {

    func executeQuery(query: PFQuery<PFObject>, completion: @escaping ([PFObject]?, Error?) -> ()) {
        query.findObjectsInBackground(block: completion)
    }

    func uploadObject(object: PFObject, completion:@escaping (Bool, Error?) -> ()) {
        object.saveInBackground(block: completion)
    }

}
