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

    private var layoutToggle = false

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
        toggleLayout(animated: false)
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


    //MARK: Actions

    @IBAction func didPressAddItemBarButtonItem(sender: UIBarButtonItem!) {
        creator.createStreamItem()
    }

    @IBAction func toggleLayoutBarButtonItemPressed(sender: UIBarButtonItem!) {
        toggleLayout(animated: true)
    }

    func didPullToRefresh(refreshControl: UIRefreshControl) {
        downloadStreamItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemViewController = segue.destination as? StreamItemViewController,
        let cell = sender as? UICollectionViewCell,
        let indexPath = collectionView?.indexPath(for: cell) {
            itemViewController.streamItem = streamItems[indexPath.item]
        }
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

    private func toggleLayout(animated: Bool) {
        let layout = layoutToggle ? LeftLayout() : RightLayout()
        collectionView?.setCollectionViewLayout(layout, animated: animated)
        layoutToggle = !layoutToggle
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



