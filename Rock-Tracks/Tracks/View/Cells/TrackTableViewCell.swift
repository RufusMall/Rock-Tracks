//
//  TrackTableViewCell.swift
//  Rock-Tracks
//
//  Created by Rufus on 11/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import UIKit

class TrackTableViewCell: UITableViewCell, TrackCellViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var spacerView: UIView!
    private var viewModel: TrackCellViewModel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = spacerView.layer
        
        let lightGrayColor = UIColor(red: 0.878, green: 0.890, blue: 0.906, alpha: 1.0)
        layer.borderColor = lightGrayColor.cgColor
        layer.borderWidth = 1.0
    }
    
    func configure(viewModel: TrackCellViewModel) {
        self.viewModel = viewModel
        viewModel.viewDelegate = self
        viewModel.start()
    }
    
    func didUpdate(viewModel: TrackCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.artistLabel.text = viewModel.artist
        self.priceLabel.text = viewModel.price
        
        self.artworkImage.image = viewModel.artworkImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel.viewDelegate = nil
    }
}
