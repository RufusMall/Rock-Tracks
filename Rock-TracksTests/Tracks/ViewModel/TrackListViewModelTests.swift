//
//  TrackListViewModel.swift
//  Rock-TracksTests
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import XCTest
@testable import Rock_Tracks

class TrackListViewModelTests: TrackTestCase, TrackListViewDelegate {
    
    var viewModel: TrackListViewModel!
    var viewModelUpdatedExpectation: XCTestExpectation?
    var viewStateBuffer = [TrackListViewModel.Output]()
    
    func didUpdate(viewState: TrackListViewModel.Output) {
        viewStateBuffer.append(viewState)
        viewModelUpdatedExpectation?.fulfill()
    }
    
    override func setUp() {
        let itunesTrackService = MockiTunesTrackService()
        setUp(service: itunesTrackService)
    }
    
    func setUp(service: TrackServiceProtocol) {
        viewModel = TrackListViewModel(trackService: service, formatter: CurrencyFormatter())
        viewStateBuffer = [TrackListViewModel.Output]()
        viewModel.viewDelegate = self
    }
    
    func testViewModelLoadItems() {
        viewModelUpdatedExpectation = self.expectation()
        viewModel.start()
        
        wait(for: [viewModelUpdatedExpectation!], timeout: 10.0)
        
        XCTAssert(viewStateBuffer.count == 1)
        let viewState = viewStateBuffer.first!
        XCTAssertEqual(viewState.cellViewModels.count, 50)
        
        let firstTrack = viewState.cellViewModels[0]
        XCTAssertNil(viewState.errorMessage)
        XCTAssertEqual(firstTrack.name, "I Am Rock")
        XCTAssertEqual(firstTrack.artist, "Rock")
        XCTAssertEqual(firstTrack.price, "$1.29")
        XCTAssertEqual(firstTrack.artworkURL, "https://is5-ssl.mzstatic.com/image/thumb/Music117/v4/d8/fe/b2/d8feb259-1e17-4f18-e120-4c38557f6714/source/100x100bb.jpg")
    }
    
    func testLoadError() {
        viewModelUpdatedExpectation = self.expectation()
        setUp(service: MockiTunesTrackService(forceErrorAfterNAttempts: 0))
        viewModel.start()
        
        wait(for: [viewModelUpdatedExpectation!], timeout: 10.0)
        
        XCTAssert(viewStateBuffer.count == 1)
        let viewState = viewStateBuffer.first!
        XCTAssertNotNil(viewState.errorMessage)
        XCTAssertEqual(viewState.errorMessage, "Server returned an unexpected result. Please try again.")
    }
    
    func testErrorAfterRefreshStillShowsOldResults() {
        viewModelUpdatedExpectation = self.expectation()
        viewModelUpdatedExpectation?.expectedFulfillmentCount = 2
        setUp(service: MockiTunesTrackService(forceErrorAfterNAttempts: 1))
        viewModel.start()
        viewModel.refresh()
        
        wait(for: [viewModelUpdatedExpectation!], timeout: 10.0)
        
        XCTAssert(viewStateBuffer.count == 2)
        
        let firstViewState = viewStateBuffer.first!
        XCTAssertEqual(firstViewState.cellViewModels.count, 50)
        
        
        let secondViewState = viewStateBuffer[1]
        XCTAssertEqual(secondViewState.cellViewModels.count, 50)
        XCTAssertNotNil(secondViewState.errorMessage)
        XCTAssertEqual(secondViewState.errorMessage, "Server returned an unexpected result. Please try again.")
    }
}
