//
// Created by Maciej Oczko on 31.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

enum SpeakersLayout {
	case vertical
}

extension UICollectionViewFlowLayout {

	convenience init(layout: SpeakersLayout) {
        self.init()
		if case .vertical = layout {
			scrollDirection = .vertical
			sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		} else {
			fatalError("Unknown layout")
		}
	}

}
