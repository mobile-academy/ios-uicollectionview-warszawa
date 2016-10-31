//
// Created by Maciej Oczko on 30.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class SpeakersDataSource: NSObject {
	fileprivate(set) lazy var speakerItems: [SpeakerItem] = self.loadSpeakerItems()
    fileprivate let cellIdentifier = "SpeakersCellIdentifier"
	fileprivate let cellClass = SpeakerCollectionViewCell.self

	func bind(with collectionView: UICollectionView) {
		collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
		collectionView.dataSource = self
	}
}

extension SpeakersDataSource: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return speakerItems.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SpeakerCollectionViewCell
		let speakerItem = speakerItems[indexPath.item]
		cell.configure(with: speakerItem)
		return cell
	}
}

extension SpeakersDataSource {
	fileprivate func loadSpeakerItems() -> [SpeakerItem] {
		return Bundle
				.main
				.paths(forResourcesOfType: "jpg", inDirectory: nil)
                .flatMap { UIImage(contentsOfFile: $0) }
				.map(SpeakerItem.init)
	}
}
