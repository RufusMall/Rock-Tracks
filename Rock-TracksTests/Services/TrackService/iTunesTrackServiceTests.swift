//
//  iTunesTrackServiceTests.swift
//  Rock-TracksTests
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import XCTest
@testable import Rock_Tracks

class iTunesTrackServiceTests: TrackTestCase {
    
    var itunesTrackService: TrackServiceProtocol!
    
    override func setUp() {
        itunesTrackService = iTunesTrackService(baseURL: testEnviornment.url)
    }
    
    override func tearDown() {
        
    }
    
    func testServiceReturnsValues() {
        let fetchCompleteExpection = self.expectation()
        
        itunesTrackService.fetchTracks(genre: .rock) { (result) in
            switch result {
            case .success(let trackListResponse):
                XCTAssert(trackListResponse.resultCount > 0)
            case .failure( _):
                XCTAssert(false)
            }
            fetchCompleteExpection.fulfill()
        }
        
        wait(for: [fetchCompleteExpection], timeout: 20.0)
    }
}
