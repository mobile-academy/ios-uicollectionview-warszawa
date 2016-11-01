//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

protocol ItemUploading {
    func uploadItem(streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ())
}
