import Quick
import Nimble

@testable
import UICollectionViewWorkshop

class PhotoStreamViewControllerSpec: QuickSpec {
    override func spec() {
        describe("PhotoStreamViewController") {
            var sut: PhotoStreamViewController!

            var downloader: StreamItemDownloaderFake!
            var uploader: StreamItemUploaderFake!
            var creator: StreamItemCreatorFake!
            var imageManipulator: ImageManipulatorFake!
            var presenter: ViewControllerPresenterFake!

            beforeEach {
                downloader = StreamItemDownloaderFake()
                uploader = StreamItemUploaderFake()
                creator = StreamItemCreatorFake()
                imageManipulator = ImageManipulatorFake()
                presenter = ViewControllerPresenterFake()

                let storyboard = UIStoryboard(name: "PhotoStream", bundle: nil)
                sut = storyboard.instantiateViewController(withIdentifier: "PhotoStream") as! PhotoStreamViewController

                sut.downloader = downloader
                sut.uploader = uploader
                sut.creator = creator
                sut.imageManipulator = imageManipulator
                sut.presenter = presenter
            }

            describe("when view loads") {
                beforeEach {
                    sut.viewDidLoad()
                }
                it("should download stream items") {
                    expect(downloader.downloadItemsCalled) == true
                }
                describe("when download finishes") {
                    var refreshControlFake: UIRefreshControlFake!
                    var collectionViewFake : UICollectionViewFake!

                    beforeEach {
                        collectionViewFake = UICollectionViewFake(frame: CGRect(),
                                collectionViewLayout: UICollectionViewFlowLayout())
                        refreshControlFake = UIRefreshControlFake()

                        sut.refreshControl = refreshControlFake
                        sut.collectionView = collectionViewFake
                    }

                    context("and is successful") {
                        beforeEach {
                            downloader.capturedCompletion?([StreamItem](), nil)
                        }
                        it("should reload collection view") {
                            expect(collectionViewFake.reloadDataCalled) == true
                        }
                        it("should stop refresh control") {
                            expect(refreshControlFake.endRefreshingCalled) == true
                        }
                    }
                    context("and failed") {
                        beforeEach {
                            let error = NSError(domain: "Foo", code: 123, userInfo: nil)
                            downloader.capturedCompletion?(nil, error)
                        }
                        it("should present alert controller") {
                            expect(presenter.capturedPresentedViewController as? UIAlertController).notTo(beNil())
                        }
                        it("should present alert controller with title Error") {
                            let alertController = presenter.capturedPresentedViewController as! UIAlertController
                            expect(alertController.title) == "Error"
                        }
                        it("should present alert controller with message 'Failed to download stream items!'") {
                            let alertController = presenter.capturedPresentedViewController as! UIAlertController
                            expect(alertController.message) == "Failed to download stream items!"
                        }
                        it("should stop refresh control") {
                            expect(refreshControlFake.endRefreshingCalled) == true
                        }
                    }
                }
            }

            describe("right bar button item") {
                var barButtonItem: UIBarButtonItem?
                beforeEach {
                    barButtonItem = sut.navigationItem.rightBarButtonItem
                }
                it("should be set") {
                    expect(barButtonItem).notTo(beNil())
                }
                describe("when pressed") {
                    beforeEach {
                        let action = barButtonItem!.action
                        sut.perform(action, with: barButtonItem)
                    }
                    it("should request item creation") {
                        expect(creator.createItemCalled) == true
                    }
                }
            }

            describe("ItemCreatingDelegate") {
                context("item was created") {
                    var fixtureItem: StreamItem!
                    beforeEach {
                        fixtureItem = StreamItem(title: "Foo", imageData: NSData())
                        sut.creator(creator: creator, didCreateItem: fixtureItem)
                    }
                    it("should upload item") {
                        expect(uploader.uploadItemCalled) == true
                    }
                    describe("when upload finished") {
                        var collectionViewFake : UICollectionViewFake!

                        beforeEach {
                            collectionViewFake = UICollectionViewFake(frame: CGRect(),
                                    collectionViewLayout: UICollectionViewFlowLayout())
                            sut.collectionView = collectionViewFake
                        }
                        context("with success") {
                            beforeEach {
                                uploader.capturedCompletion?(true, nil)
                            }
                            it("should reload collection view") {
                                expect(collectionViewFake.reloadDataCalled) == true
                            }
                            it("should add item to stream item list") {
                                expect(sut.streamItems.count) == 1
                            }
                            it("should add uploaded item to stream item list") {
                                let item = sut.streamItems[0]
                                expect(item.title).to(equal("Foo"))
                                expect(item.imageData).to(equal(fixtureItem.imageData))
                            }
                        }
                        context("with failure") {
                            beforeEach {
                                let error = NSError(domain: "Foo", code: 123, userInfo: nil)
                                uploader.capturedCompletion?(false, error)
                            }
                            it("should present alert controller") {
                                expect(presenter.capturedPresentedViewController as? UIAlertController).notTo(beNil())
                            }
                            it("should present alert controller with title Error") {
                                let alertController = presenter.capturedPresentedViewController as! UIAlertController
                                expect(alertController.title) == "Error"
                            }
                            it("should present alert controller with message 'Failed to upload stream item!'") {
                                let alertController = presenter.capturedPresentedViewController as! UIAlertController
                                expect(alertController.message) == "Failed to upload stream item!"
                            }
                        }
                    }
                }
                context("failed to create item") {
                    beforeEach {
                        sut.creator(creator: creator, failedWithError: NSError(domain:"Foo", code: 123, userInfo: nil))
                    }
                    it("should present alert controller") {
                        expect(presenter.capturedPresentedViewController as? UIAlertController).notTo(beNil())
                    }
                    it("should present alert controller with title Error") {
                        let alertController = presenter.capturedPresentedViewController as! UIAlertController
                        expect(alertController.title) == "Error"
                    }
                    it("should present alert controller with message 'Failed to create stream item!'") {
                        let alertController = presenter.capturedPresentedViewController as! UIAlertController
                        expect(alertController.message) == "Failed to create stream item!"
                    }
                }
            }
        }
    }
}
