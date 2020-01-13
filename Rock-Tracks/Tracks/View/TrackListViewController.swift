//
//  ViewController.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController, TrackListViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: TrackListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navController = self.navigationController {
            //make the navigation bar transparent, but still show the back button
            navController.navigationBar.shadowImage = UIImage()
            navController.navigationBar.backgroundColor = .clear
            navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.isTranslucent = true
        }
        
        let trackService = iTunesTrackService(baseURL: Environment.dev.url)
        let currencyFormatter = CurrencyFormatter()
        viewModel = TrackListViewModel(trackService: trackService, formatter: currencyFormatter)
        
        viewModel.start()
        viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            if let navRootAsTrackDetails = navigationController.topViewController as? TrackDetailsViewController {
                if let selectedRowPath = self.tableView.indexPathForSelectedRow {
                    let track = self.viewModel.track(for: selectedRowPath.row)
                    navRootAsTrackDetails.viewModel = TrackDetailsViewModel(track: track)
                }
            }
        }
    }
    
    func didUpdate(viewState: TrackListViewModel.Output) {
        self.tableView.reloadData()
    }
}

extension TrackListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackCell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as! TrackTableViewCell
        let cellViewModel = viewModel.output.cellViewModels[indexPath.row]
        trackCell.configure(viewModel: cellViewModel)
        return trackCell
    }
}
