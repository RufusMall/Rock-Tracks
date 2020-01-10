//
//  ViewController.swift
//  Rock-Tracks
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        self.tableView.dataSource = self
    }
}

extension TrackListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath)
        cell.textLabel?.text = "TrackCell"
        return cell
    }
}
