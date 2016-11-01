//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItemCreator: NSObject, ItemCreating, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties

    weak var delegate: ItemCreatingDelegate?

    var controllerPresenter: ViewControllerPresenting
    var resourceAvailability: SourceTypeAvailability
    var actionFactory: AlertActionCreating
    var pickerFactory: ImagePickerCreating
    var imageManipulator: ImageManipulating

    //MARK: Object Life Cycle

    init(presenter: ViewControllerPresenting) {
        controllerPresenter = presenter
        resourceAvailability = DefaultSourceTypeProvider()
        actionFactory = DefaultAlertActionFactory()
        pickerFactory = DefaultImagePickerFactory()
        imageManipulator = DefaultImageManipulator()
    }

    //MARK: ItemCreating

    func createStreamItem() {
        let sources = resourceAvailability.availableSources()
        switch (sources.count) {
            case 0:
                delegate?.creator(creator: self, failedWithError: NSError(domain: "TDDWorkshop", code:-1, userInfo: nil))
            case 1:
                presentPickerWithResourceType(sourceType: sources.first!)
            default:
                presentSourcesActionSheet(sources: sources)
        }
    }

    //MARK: UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        controllerPresenter.dismissViewController(viewController: picker)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            let error = NSError(domain: "TDDWorkshop", code: -1, userInfo: nil)
            delegate?.creator(creator: self, failedWithError: error)
            return
        }
        let alertController = createTitleAlertController()
        let alertAction = actionFactory.createActionWithTitle(title: "OK", style: .default) {
            [weak self] action in
            let title = self?.itemTitleFromTitleAlertController(alertController: alertController)
            let streamItem = self?.createItemWithTitle(title: title!, pickedImage: image)
            self?.delegate?.creator(creator: self!, didCreateItem: streamItem!)
        }
        alertController.addAction(alertAction)
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controllerPresenter.dismissViewController(viewController: picker)
    }

    //MARK: Private methods

    private func itemTitleFromTitleAlertController(alertController: UIAlertController) -> String {
        guard let title = alertController.textFields?.first?.text else {
            return "No title provided:("
        }
        return title
    }

    private func createItemWithTitle(title: String, pickedImage: UIImage) -> StreamItem {
        let scaledImage = imageManipulator.scaleImage(image: pickedImage, maxDimension: 500)
        let imageData = imageManipulator.dataFromImage(image: scaledImage, quality: 0.7)
        let streamItem = StreamItem(title: title, imageData: imageData)
        return streamItem
    }

    private func createTitleAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "Title of the item", message: nil, preferredStyle: .alert)
        controllerPresenter.presentViewController(viewController: alertController)
        alertController.addTextField {
            textField in
            textField.placeholder = "Something funny"
        }
        return alertController
    }

    private func presentSourcesActionSheet(sources: [UIImagePickerControllerSourceType]) {
        let alertController = UIAlertController(title: "Add new Item to the stream", message: nil, preferredStyle: .actionSheet)
        addImagePickerActionsToAlertController(alertController: alertController, forSources: sources)
        let cancelAction = actionFactory.createActionWithTitle(title: "Cancel", style: .cancel) {
            action in
        }
        alertController.addAction(cancelAction)
        controllerPresenter.presentViewController(viewController: alertController)
    }

    private func addImagePickerActionsToAlertController(alertController: UIAlertController,
                                                        forSources sources: [UIImagePickerControllerSourceType]) {
        for source in sources {
            switch (source) {
            case .photoLibrary:
                let alertAction = actionFactory.createActionWithTitle(title: "Pick from Library", style: .default) {
                    [weak self] action in
                    self?.presentPickerWithResourceType(sourceType: .photoLibrary)
                }
                alertController.addAction(alertAction)
            case .camera:
                let alertAction = actionFactory.createActionWithTitle(title: "Take a Photo", style: .default) {
                    [weak self] action in
                    self?.presentPickerWithResourceType(sourceType: .camera)
                }
                alertController.addAction(alertAction)
            default:
                break
            }
        }
    }

    private func presentPickerWithResourceType(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = pickerFactory.createPickerWithSourceType(sourceType: sourceType)
        imagePicker.delegate = self
        controllerPresenter.presentViewController(viewController: imagePicker)
    }
}
