import Quick
import Nimble

@testable
import UICollectionViewWorkshop

class StreamItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("StreamItemViewController") {
            var sut: StreamItemViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "PhotoStream", bundle: nil)
                sut = storyboard.instantiateViewController(withIdentifier: "StreamItemPreview") as! StreamItemViewController
            }
            it("should work") {
                expect(sut).notTo(beNil())
            }
        }
    }
}
