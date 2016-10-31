//
// Created by Maciej Oczko on 31.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

enum SpeakersLayout {
	case vertical
	case horizontal
}

extension UICollectionViewFlowLayout {

	convenience init(layout: SpeakersLayout) {
        self.init()
		switch layout {
			case .vertical:
				scrollDirection = .vertical
				break
			case .horizontal:
				scrollDirection = .horizontal
				minimumLineSpacing = 20
				break
		}
		sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}

}
