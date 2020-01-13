//
//  TrackCellViewModel.swift
//  Rock-Tracks
//
//  Created by Rufus on 13/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

protocol TrackCellViewDelegate: class {
    func didUpdate(viewModel: TrackCellViewModel)
}

class TrackCellViewModel {
    public let name, artist, artworkURL: String
    public let price: String?
    public var artworkImage: UIImage
    public weak var viewDelegate: TrackCellViewDelegate?
    
    private let track: Track
    private let webClient: WebClientProtocol
    
    init(track: Track, formatter:CurrencyFormatter, webClient: WebClientProtocol) {
        self.track = track
        self.webClient = webClient
        
        let currencyCode = track.currency
        let price = track.trackPrice
        
        self.name = track.trackName
        self.artist = track.artistName
        self.price = formatter.format(currencyCode: currencyCode, amount: price)
        self.artworkURL = track.artworkUrl100
        
        self.artworkImage = UIImage(named: "artworkPlaceholder")!
    }
    
    func start() {
        viewDelegate?.didUpdate(viewModel: self)
        let imageURL = URL(string: track.artworkUrl100)!
        
        webClient.get(url: imageURL) { result in
            //incase of any errors, just keep showing the placeholder
            switch result {
            case .success(let data):
                if let image = UIImage(data: data){
                    self.artworkImage = image
                    self.viewDelegate?.didUpdate(viewModel: self)
                }
            case .failure(let error):
                print("Error Loading Image: \(error)")
            }
        }
    }
}
