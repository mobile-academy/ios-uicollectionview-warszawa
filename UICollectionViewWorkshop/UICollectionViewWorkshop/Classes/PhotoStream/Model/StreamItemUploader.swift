//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation

class StreamItemUploader: ItemUploading {

    let parseAdapter: ParseAdapting
    var transformer = StreamItemTransformer()

    //MARK: Object Life Cycle

    init (parseAdapter: ParseAdapting) {
        self.parseAdapter = parseAdapter
    }

    //MARK: ItemUploading

    func uploadItem(streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ()) {
        let parseObject = transformer.parseObjectFromStreamItem(streamItem: streamItem)
        parseAdapter.uploadObject(object: parseObject, completion: completion)
    }
}
