//
// Created by Maciej Oczko on 30.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class SpeakerCollectionViewCell: UICollectionViewCell {
	private(set) lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(imageView)
		clipsToBounds = true
	}

	func configure(with speakerItem: SpeakerItem) {
		imageView.image = speakerItem.image
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.frame = bounds
	}

}
