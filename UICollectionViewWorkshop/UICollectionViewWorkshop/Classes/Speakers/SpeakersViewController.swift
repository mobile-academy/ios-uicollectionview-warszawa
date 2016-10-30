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

    HINT 1: This controller should be a collection view delegate.
    HINT 2: `SpeakersDataSource` should be a collection view data source.
 */


final class SpeakersViewController: UIViewController {

	let dataSource: SpeakersDataSource

	init(dataSource: SpeakersDataSource) {
		self.dataSource = dataSource
		super.init(nibName: nil, bundle: nil)
		title = "Speakers"
		tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Speakers"), tag: 1)
	}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Sadly, this is required...")
    }

	override func loadView() {
		// Remove this after setting self.view
		super.loadView()

		// TODO 1. You should create a UICollectionView with UICollectionViewFlowLayout here.
		// This is a place where you can set collection view's delegate and data source.

		// HINT 1: Remember about special delegate protocol for UICollectionViewFlowLayout.
		// HINT 2: For setting data source please see `bind(with collectionView)` method in `SpeakersDataSource` class (which should be called in viewDidLoad).
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white
	}
}

extension SpeakersViewController: UICollectionViewDelegate /* FlowLayout */ {

	// TODO 4. You should override `collectionView(_, layout, sizeForItemAt)` method to provide cell size.
	// HINT: Remember about special delegate protocol for UICollectionViewFlowLayout.

}
