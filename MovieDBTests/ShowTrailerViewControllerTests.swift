//
//  ShowTrailerViewControllerTests.swift
//  MovieDBTests
//
//  Created by German Huerta on 10/09/21.
//

import XCTest
@testable import MovieDB

class ShowTrailerViewControllerTests: XCTestCase {
    var sutViewController:ShowTrailerViewController!
    var mockVM = DetailViewModelMock.createMockDetailModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sutViewController = self.makeSUT()
    }
    
    func test_webView_exists() {
        XCTAssertNotNil(sutViewController.webView, "The webiew is nil")
    }

    func test_closeButton_hasActionAssigned() {
        
        //Check if Controller has UIButton property
        let closeButton: UIButton = sutViewController.closeButton
        XCTAssertNotNil(closeButton, "View Controller does not have UIButton property")
        
        // Attempt Access UIButton Actions
        guard let closeButtonActions = closeButton.actions(forTarget: sutViewController, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
     
        // Assert UIButton has action with a method name
        XCTAssertTrue(closeButtonActions.contains("closeButtonTapped:"))
    }
    func makeSUT() -> ShowTrailerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "ShowTrailerViewController") as! ShowTrailerViewController
        
        sut.config(with: mockVM.getTrailer(at: 0))
        sut.loadViewIfNeeded()
        return sut
    }

}
