//
//  TrackListViewModel.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

class TrackViewModel {
    let name, artist, price, artworkURL: String
    
    init(track: Track) {
        self.name = track.trackName
        self.artist = track.artistName
        self.price = "\(track.trackPrice)"
        self.artworkURL = track.artworkUrl100
    }
}

public protocol TrackListViewDelegate: class {
    func didUpdate(viewState: TrackListViewModel.Output)
}

public class TrackListViewModel {
    public struct Output {
        let trackListItems: [TrackViewModel]
        let errorMessage: String?
    }
    
    public weak var viewDelegate: TrackListViewDelegate?
    
    private let trackService: TrackServiceProtocol
    private var output: Output
    
    init(trackService: TrackServiceProtocol) {
        self.trackService = trackService
        self.output = Output(trackListItems: [], errorMessage: nil)
    }
    
    func start() {
        refresh()
    }
    
    func refresh() {
        trackService.fetchTracks(genre:.rock) { result in
            switch result {
            case .success(let response):
                let trackVMs =  response.results.map({TrackViewModel(track:$0)})
                self.output = Output(trackListItems: trackVMs, errorMessage: nil)
            case .failure(let error):
                self.output = Output(trackListItems: self.output.trackListItems, errorMessage: error.localizedDescription)
            }
            
            self.viewDelegate?.didUpdate(viewState:self.output)
        }
    }
}
