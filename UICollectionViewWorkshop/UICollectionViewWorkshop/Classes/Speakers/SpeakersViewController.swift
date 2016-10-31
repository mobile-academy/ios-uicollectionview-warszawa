//
//  SpeakersViewController.swift
//  UICollectionViewWorkshop
//
//  Created by Maciej Oczko on 30.10.2016.
//  Copyright © 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

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
		let dimension = collectionView.frame.width * 0.5 - 20
		return CGSize(width: dimension, height: dimension)
	}

}
