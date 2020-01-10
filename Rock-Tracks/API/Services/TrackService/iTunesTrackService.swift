//
//  iTunesService.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public enum Environment: String {
    case dev = "https://itunes.apple.com"
    
    public var url: URL {
        return URL(string: self.rawValue)!
    }
}

private enum iTunesAPI {
    case search(genre: Genre)
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .search(let genre):
            return [URLQueryItem(name: "term", value: genre.rawValue),URLQueryItem(name: "media", value: "music")]
        }
    }
    
    var path: String {
        return "\(self)"
    }
    
    func createURL(baseURL: URL) -> URL {
        let urlPath = baseURL.appendingPathComponent(path)//.apenndin(path)
        var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = self.queryParams
        let completeURL = urlComponents.url!
        return completeURL
    }
}




public class iTunesTrackService: BaseService, TrackServiceProtocol {
    public func fetchTracks(genre:Genre, completion: @escaping FetchTracksCompletion) {
        let api = iTunesAPI.search(genre: genre)
        let url = api.createURL(baseURL: self.baseURL)
        get(url: url, completion: completion)
    }
}
