//
//  MockiTunesTrackService.swift
//  Rock-TracksTests
//
//  Created by Rufus on 11/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import Rock_Tracks

class MockiTunesTrackService: BaseMockService, TrackServiceProtocol {
    func fetchTracks(genre: Genre, completion: @escaping FetchTracksCompletion) {
        
        let result: TrackListResponse = loadFromBundledJson(named: "mockRockTrackResponse", withExtension: "json")
        executeCompletionOrSimulateError(object:result, completion: completion)
    }
}
