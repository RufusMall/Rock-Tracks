//
//  TrackService.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public enum Genre: String {
    case rock
}

public protocol TrackServiceProtocol {
    typealias FetchTracksCompletion = (Result<TrackListResponse,Error>) -> ()
    func fetchTracks(genre:Genre, completion: @escaping FetchTracksCompletion)
}
