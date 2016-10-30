//
// Created by Maciej Oczko on 30.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class SpeakersDataSource {
	private(set) lazy var speakerItems: [SpeakerItem] = self.loadSpeakerItems()
	private let cellIdentifier = "SpeakersCellIdentifier"
	private let cellClass = SpeakerCollectionViewCell.self

	func bind(with collectionView: UICollectionView) {
		// TODO 2. To bind collection view with data source, you have to do the following:
		// - Register cell class for identifier.
		// - Set itself as a collection view data source. (HINT: Remember to add protocol in class header)
	}
}

//extension SpeakersDataSource: UICollectionViewDataSource {
	// TODO 3. There are 2 required methods of UICollectionViewDataSource you need to implement
	// - `-collectionView(_, numberOfItemsInSection)`
	// - `-collectionView(_, cellForItemAt)` (HINT: The cell that is returned must be retrieved from a call to `-dequeueReusableCell(withReuseIdentifier,for)`
//}

extension SpeakersDataSource {
	fileprivate func loadSpeakerItems() -> [SpeakerItem] {
		return Bundle
				.main
				.paths(forResourcesOfType: "jpg", inDirectory: nil)
                .flatMap { UIImage(contentsOfFile: $0) }
				.map(SpeakerItem.init)
	}
}
