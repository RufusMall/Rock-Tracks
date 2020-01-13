//
//  TrackListViewModel.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import UIKit.UIImage

public protocol TrackListViewDelegate: class {
    func didUpdate(viewState: TrackListViewModel.Output)
}

public class TrackListViewModel {
    public struct Output {
        let cellViewModels: [TrackCellViewModel]
        let errorMessage: String?
    }
    
    public weak var viewDelegate: TrackListViewDelegate?
    public var output: Output
    private var tracks = [Track]()
    private let trackService: TrackServiceProtocol
    private let currencyFormatter: CurrencyFormatter
    private let webClient: WebClientProtocol
    
    init(trackService: TrackServiceProtocol, formatter: CurrencyFormatter, webClient: WebClientProtocol = WebClient.shared) {
        self.trackService = trackService
        self.currencyFormatter = formatter
        self.webClient = webClient
        self.output = Output(cellViewModels: [], errorMessage: nil)
    }
    
    public func track(for index: Int) -> Track {
        return tracks[index]
    }
    
    public func start() {
        refresh()
    }
    
    public func refresh() {
        trackService.fetchTracks(genre:.rock) { result in
            switch result {
            case .success(let response):
                self.tracks = response.results
                let formatter = self.currencyFormatter
                let trackVMs =  response.results.map({
                    TrackCellViewModel(track:$0, formatter: formatter, webClient: self.webClient)
                })
                self.output = Output(cellViewModels: trackVMs, errorMessage: nil)
            case .failure(let error):
                self.output = Output(cellViewModels: self.output.cellViewModels, errorMessage: error.localizedDescription)
            }
            
            self.viewDelegate?.didUpdate(viewState:self.output)
        }
    }
}
