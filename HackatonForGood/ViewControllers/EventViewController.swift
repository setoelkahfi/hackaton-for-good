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
    
    var event: Event = Event()
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let feedTableViewCell = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedTableViewCell, forCellReuseIdentifier: "FeedTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }
    
    private func reloadData() {
        let parameterDictionary: [String : Any] = [
            "title" : "Event: Server cleanup!",
            "description" : "Let’s clean the server beach this Sunday morning and prepare it for the sunny summer!",
            "going": true
        ]
        
        let url = URL(string: "https://iyti06qz37.execute-api.eu-west-1.amazonaws.com/default/")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else { return }
        urlRequest.httpBody = httpBody
        
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
           do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
            print(json)
            self.event.title = json["Title"] as? String ?? "Title"
            self.event.description = json["description"] as? String ?? "Description"
            self.event.going = json["going"] as? Bool ?? false
            print(self.event.title)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }

        task.resume()
    }
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        cell.title.text = self.event.title
        cell.descriptionLabel.text = self.event.description
        cell.joinButton.backgroundColor = self.event.going ? UIColor.black : UIColor.red
        cell.joinButton.titleLabel?.text = self.event.going ? "I'M GOING!" : "Join"
        return cell
    }
    
    
    
}
