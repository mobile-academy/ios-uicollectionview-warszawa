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

		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(switchLayouts))
	}

	func switchLayouts() {
		guard let fromLayout = speakersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError("Wrong layout.") }

		let isHorizontalLayout = fromLayout.scrollDirection == .horizontal

		let toLayout: UICollectionViewLayout
		if isHorizontalLayout {
            toLayout = UICollectionViewFlowLayout(layout: .vertical)
		} else {
            toLayout = UICollectionViewFlowLayout(layout: .horizontal)
		}

		speakersCollectionView.isPagingEnabled = !isHorizontalLayout
		speakersCollectionView.setCollectionViewLayout(toLayout, animated: true)
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
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError("Wrong layout passed.") }

		let size: CGSize
		if case .horizontal = flowLayout.scrollDirection {
            let height = collectionView.bounds.height - collectionView.contentInset.top - collectionView.contentInset.bottom
			size = CGSize(width: collectionView.bounds.width, height: height)
		} else {
            let dimension = collectionView.bounds.width * 0.5
			size = CGSize(width: dimension, height: dimension)
		}

        let margin: CGFloat = 20
		return CGSize(width: size.width - margin, height: size.height - margin)
	}

}
