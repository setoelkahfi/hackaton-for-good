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
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        let feedTableViewCell = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedTableViewCell, forCellReuseIdentifier: "FeedTableViewCell")
        
        let parameterDictionary: [String : Any] = [
            "title" : "Test",
            "description" : "123456",
            "going": true
        ]
        
        let url = URL(string: "https://iyti06qz37.execute-api.eu-west-1.amazonaws.com/default/")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
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
            
            self.tableView.reloadData()
            
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
        
        
        
        return cell
    }
    
    
    
}
