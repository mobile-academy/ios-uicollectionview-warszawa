//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController, ItemCreatingDelegate {

    var parseAdapter: ParseAdapting
    var downloader: ItemDownloading
    var creator: ItemCreating
    var uploader: ItemUploading
    var imageManipulator: ImageManipulating
    var presenter: ViewControllerPresenting
    var alertActionFactory: AlertActionCreating
    var refreshControl: UIRefreshControl

    var streamItems = [StreamItem]()

    required init?(coder: NSCoder) {
        parseAdapter = DefaultParseAdapter()
        presenter = DefaultViewControllerPresenter()
        imageManipulator = DefaultImageManipulator()
        refreshControl = UIRefreshControl()
        downloader = StreamItemDownloader(parseAdapter: parseAdapter)
        creator = StreamItemCreator(presenter: presenter)
        uploader = StreamItemUploader(parseAdapter: parseAdapter)
        alertActionFactory = DefaultAlertActionFactory()

        super.init(coder: coder)
        presenter.viewController = self
        creator.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        downloadStreamItems()
    }

    //MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoStreamCell", for: indexPath as IndexPath)
        if let photoCell = cell as? PhotoStreamCell {
            let streamItem = streamItems[indexPath.row]
            photoCell.imageView.image = imageManipulator.imageFromData(data: streamItem.imageData)
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = createStreamItemViewController() {
            viewController.streamItem = streamItems[indexPath.item]
            viewController.useLayoutToLayoutNavigationTransitions = true
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    //MARK: Actions

    @IBAction func didPressAddItemBarButtonItem(sender: UIBarButtonItem!) {
        creator.createStreamItem()
    }

    func didPullToRefresh(refreshControl: UIRefreshControl) {
        downloadStreamItems()
    }

    //MARK: ItemCreatingDelegate

    func creator(creator: ItemCreating, didCreateItem item: StreamItem) {
        uploader.uploadItem(streamItem: item) {
            [weak self] success, error in
            if success == false {
                self?.presentErrorAlertWithMessage(message: "Failed to upload stream item!")
            } else {
                self?.addItem(item: item)
            }
        }
    }

    func creator(creator: ItemCreating, failedWithError: Error) {
        presentErrorAlertWithMessage(message: "Failed to create stream item!")
    }

    //MARK: Private methods

    private func createStreamItemViewController() -> StreamItemViewController? {
        let viewController = UIStoryboard(name: "PhotoStream", bundle: nil).instantiateViewController(withIdentifier: "StreamItemPreview")
        return viewController as? StreamItemViewController
    }

    private func addItem(item:StreamItem) {
        streamItems.append(item)
        collectionView?.reloadData()
    }

    private func presentErrorAlertWithMessage(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(alertActionFactory.createActionWithTitle(title: "Cancel", style: .cancel) {
            action in })
        presenter.presentViewController(viewController: errorAlert)
    }

    private func setupCollectionView() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refreshControl)
        collectionView?.alwaysBounceVertical = true
    }

    private func downloadStreamItems() {
        downloader.downloadItems {
            [weak self] items, error in
            self?.refreshControl.endRefreshing()
            if error != nil || items == nil {
                self?.presentErrorAlertWithMessage(message: "Failed to download stream items!")
            } else {
                self?.streamItems = items!
                self?.collectionView?.reloadData()
            }
        }
    }
}



