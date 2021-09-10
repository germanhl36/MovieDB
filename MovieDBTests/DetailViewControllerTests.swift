//
//  DetailViewControllerTests.swift
//  MovieDBTests
//
//  Created by German Huerta on 10/09/21.
//

import XCTest
@testable import MovieDB

class DetailViewControllerTests: XCTestCase {

    var sutViewController:DetailViewController!
    var mockVM = DetailViewModelMock.createMockDetailModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sutViewController = self.makeSUT()
    }

    
    func test_detailviewcontroller_content_contains_vm_title() {
        let content = sutViewController.titleLabel.text
        let titleOnVM = mockVM.getTitle()
        XCTAssertTrue(content == titleOnVM, "The content of the DetailViewController is not  equal to the title of the vm")
    }
    
    
    func test_detailviewcontroller_content_contains_vm_overview() {
        let content = sutViewController.overviewLabel.text
        let titleOnVM = mockVM.getOverview()
        XCTAssertTrue(content == titleOnVM, "The content of the DetailViewController is not  equal to the overview of the vm")
    }
    
    func test_detailviewcontroller_content_contains_vm_voteAverage() {
        let content = sutViewController.voteAverageLabel.text
        let onVM = mockVM.getVoteAverage()
        XCTAssertTrue(content == onVM, "The content of the DetailViewController is not  equal to the voteAverage of the vm")
    }
    
    func test_detailviewcontroller_content_contains_vm_realeseDate() {
        let content = sutViewController.releaseDate.text
        let onVM = mockVM.getReleaseDate()
        XCTAssertTrue(content == onVM, "The content of the DetailsViewController is not  equal to the release date of the vm")
    }
    
    func test_detailviewcontroller_content_contains_vm_duration() {
        let content = sutViewController.durationLabel.text
        let onVM = mockVM.getMovieDuration()
        XCTAssertTrue(content == onVM, "The content of the DetailsViewController is not  equal to the duration of the vm")
    }
    
    func test_collectionView_numberOfItemsInSection() {
        let imageCount = mockVM.getTrailerCount()
        
        XCTAssertTrue(imageCount == sutViewController.collectionView(sutViewController.trailerCollectionView, numberOfItemsInSection: 0),"The numberOfItemsInSection function returned a number different than the getTrailerCount function of the model")
    }
    
    func test_collectionView_numberOfItemsInSection_NotNil(){
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.trailerCollectionView, numberOfItemsInSection: 0), "The numberOfRowsInSection function returned nil")
    }
    
    func test_tableView_CellForRow_NotNil(){
        
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.trailerCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)), "The cellForItemAt function returned nil ")
    }
    
    func makeSUT() -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        sut.config(with: mockVM)
        sut.loadViewIfNeeded()
        return sut
    }
}
