//
//  TrackDetailsViewController.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

class TrackDetailsViewController: UIViewController, TrackDetailsViewDelegate {
    
    public var viewModel: TrackDetailsViewModel?
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = self.navigationController {
            //hide navigation bar
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.backgroundColor = .clear
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.isTranslucent = true
        }
        
        viewModel?.viewDelegate = self
        viewModel?.start()
        
    }
    
    func didUpdate(viewState: TrackDetailsViewModel.Output) {
        self.artworkImageView.image = viewState.artworkImage
        self.trackNameLabel.text = viewState.name
        self.artistLabel.text = viewState.artist
        self.trackPriceLabel.text = viewState.price
        self.durationLabel.text = viewState.duration
        self.releaseDateLabel.text = viewState.releaseDate
        
        if let moreDetailsURL = viewState.moreDetailsURL {
            //would be better as seperate view model or some sort of view service
            if UIApplication.shared.openURL(moreDetailsURL) {
                return
            }
        }
    }
    
    @IBAction func didPressMoreDetails(_ sender: Any) {
        viewModel?.didTapMoreDetails()
    }
}
