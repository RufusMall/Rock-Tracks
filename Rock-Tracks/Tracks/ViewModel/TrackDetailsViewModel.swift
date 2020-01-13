//
//  TrackDetailsViewModel.swift
//  Rock-Tracks
//
//  Created by Rufus on 13/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

protocol TrackDetailsViewDelegate: class {
    func didUpdate(viewState: TrackDetailsViewModel.Output)
}

class TrackDetailsViewModel {
    public struct Output {
        public let name, artist: String
        public let price, duration, releaseDate: String?
        public var moreDetailsURL: URL?
        public var artworkImage: UIImage
    }
    
    public weak var viewDelegate: TrackDetailsViewDelegate?
    
    private var output: Output
    private let track: Track
    private let webClient: WebClientProtocol
    
    init(track: Track, formatter: CurrencyFormatter = CurrencyFormatter(), webClient: WebClientProtocol = WebClient.shared) {
        self.track = track
        self.webClient = webClient
        
        let currencyCode = track.currency
        let price = formatter.format(currencyCode: currencyCode, amount: track.trackPrice)
        let durationInSeconds = track.trackTimeMillis / 1000
        let duration = TimeInterval(durationInSeconds).minuteSecondMS
        
        let dateFormatter = TrackDateFormatter()

        var formattedReleaseDate = "Released: -"
        if let releaseDate = dateFormatter.getFormattedDate(iso8601: track.releaseDate) {
             formattedReleaseDate = "Released: \(releaseDate)"
        }
        
        let artworkImage  = UIImage(named: "artworkPlaceholder")!
        
        self.output = Output(name: track.trackName, artist: track.artistName, price: price, duration: duration, releaseDate: formattedReleaseDate, moreDetailsURL: nil, artworkImage: artworkImage)
    }
    
    func start() {
        viewDelegate?.didUpdate(viewState: self.output)
        
        let imageURL = URL(string: track.artworkUrl100)!
        
        webClient.get(url: imageURL) { result in
            //incase of any errors, just keep showing the placeholder
            switch result {
            case .success(let data):
                if let image = UIImage(data: data){
                    self.output.artworkImage = image
                    self.viewDelegate?.didUpdate(viewState: self.output)
                }
            case .failure(let error):
                print("Error Loading Image: \(error)")
            }
        }
    }
    
    func didTapMoreDetails() {
        self.output.moreDetailsURL = URL(string: self.track.trackViewURL)
        self.viewDelegate?.didUpdate(viewState: self.output)
        self.output.moreDetailsURL = nil
    }
}

//adapted from: https://stackoverflow.com/questions/30771820/swift-convert-milliseconds-into-minutes-seconds-and-milliseconds
extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
