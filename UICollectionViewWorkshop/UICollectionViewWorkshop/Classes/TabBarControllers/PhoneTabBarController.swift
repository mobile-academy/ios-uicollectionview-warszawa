//
// Created by Maciej Oczko on 30.10.2016.
// Copyright (c) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

final class PhoneTabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.titleView = UIImageView(image: UIImage(named: "OnlyLogo"))
		viewControllers = [
				SpeakersViewController(dataSource: SpeakersDataSource()),
				CalendarViewController(),
		]
	}

}
