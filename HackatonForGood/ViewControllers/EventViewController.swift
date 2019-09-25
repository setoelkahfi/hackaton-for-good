//
//  EventViewController.swift
//  HackatonForGood
//
//  Created by Seto Elkahfi on 25/09/19.
//  Copyright © 2019 Seto Elkahfi. All rights reserved.
//

import Foundation
import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let feedTableViewCell = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedTableViewCell, forCellReuseIdentifier: "FeedTableViewCell")
        
        
        
    }
    
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        
        
        
        return cell
    }
    
    
    
}
