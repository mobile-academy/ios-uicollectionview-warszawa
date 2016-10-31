//
//  SpeakersViewController.swift
//  UICollectionViewWorkshop
//
//  Created by Maciej Oczko on 30.10.2016.
//  Copyright © 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

/*
    This is a view controller for managing collection view.
    It takes `SpeakersDataSource` as a dependency to provide items for collection view.

    Please follow the TODOs to complete this exercise.
    (To list TODOs in AppCode use CMD+6 shortcut.)

    HINT 1: Only this file need to be changed.
    HINT 2: Implement `switchLayouts()` and `sizeForItemAt(indexPath)` methods. See TODOs.
 */


final class SpeakersViewController: UIViewController {

	let dataSource: SpeakersDataSource = SpeakersDataSource()
	private var speakersCollectionView: UICollectionView {
		return view as! UICollectionView
	}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Speakers"
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Speakers"), tag: 1)
    }

	override func loadView() {
		let layout = UICollectionViewFlowLayout(layout: .vertical)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view = collectionView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white

		speakersCollectionView.delegate = self
		dataSource.bind(with: speakersCollectionView)

		// TODO 1. Create UIBarButtonItem for rightBarButtonItem for `switchLayouts`
	}

	func switchLayouts() {
		// TODO 2. You have to toggle between 2 flow layouts
		// first: `.vertical` and second `.horizontal` (See _UICollectionViewFlowLayout+SpeakersLayout_ file for definitions)
		//
		// HINT 1. You can test `scrollDirection` property of flow layout to determine which layout should be applied.
		// HINT 2. To apply layout call `setCollectionViewLayout(_, animated)` on collection view.
		// HINT 3. You can enable paging (`pagingEnabled`) on collection view for horizontal layout
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
        DispatchQueue.once {
            self.speakersCollectionView.contentInset = UIEdgeInsetsMake(topLayoutGuide.length, 0, bottomLayoutGuide.length, 0)
        }
	}

}

extension SpeakersViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var size = CGSize.zero;
		// TODO 3. You have to calculate different sizes for vertical and horizontal layout
		// HINT 1: Vertical cell size remains the same.

		// Uncomment following code and implement.
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError("Wrong layout passed.") }
		if case .horizontal = flowLayout.scrollDirection {

		} else {

		}

        let margin: CGFloat = 20
		return CGSize(width: size.width - margin, height: size.height - margin)
	}

}
