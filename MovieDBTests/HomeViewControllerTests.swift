//
//  HomeViewControllerTests.swift
//  MovieDBTests
//
//  Created by German Huerta on 10/09/21.
//

import XCTest
@testable import MovieDB

class HomeViewControllerTests: XCTestCase {

    var sutViewController:HomeViewController!
    var mockHomeVM = HomeViewModelMock()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sutViewController = self.makeSUT()

    }

    func test_collectionView_numberOfItemsInSection() {
        let imageCount = mockHomeVM.getCount()
        
        XCTAssertTrue(imageCount == sutViewController.collectionView(sutViewController.collectionView, numberOfItemsInSection: 0),"The numberOfItemsInSection function returned a number different than the getImages().count function of the model")
    }
    
    func test_collectionView_numberOfItemsInSection_NotNil(){
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.collectionView, numberOfItemsInSection: 0), "The numberOfRowsInSection function returned nil")
    }
    
    func test_tableView_CellForRow_NotNil(){
        
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)), "The cellForItemAt function returned nil ")
    }
    func makeSUT() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        sut.config(withVM: mockHomeVM)
        sut.loadViewIfNeeded()
        return sut
    }
}
