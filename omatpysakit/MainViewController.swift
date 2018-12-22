//
//  MainViewController.swift
//  omatpysakit
//
//  Created by Essi Jukkala on 22/12/2018.
//  Copyright © 2018 Essi Jukkala. All rights reserved.
//

import UIKit
import Apollo

class staticApollo {
    static let graphQLEndpoint = "https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql"
    static let apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)
}

public typealias Long = Int

extension Int {
    public init(jsonValue value: JSONValue) throws {
        guard let string = value as? String else {
            throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
        }
        guard let number = Int(string) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Int64.self)
        }
        
        self = number
    }
    
    public var jsonValue: JSONValue {
        return String(self)
    }
}

struct Stop {
    let name: String
    let id: String
}

class MainViewController: UITableViewController {
    
    var stops: [Stop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        stops.append(Stop(name: "Kaisaniemenkatu", id: "HSL:1020457"))
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StopViewControllerCell") as? StopViewControllerCell else { fatalError() }
        cell.stopName.text = stops[indexPath.row].name
        cell.stop = stops[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == "StopInfo" {
            guard let destination = segue.destination as? StopViewController else { return }
            guard let sender = sender as? StopViewControllerCell else { return }
            destination.stop = sender.stop
            destination.saveButton.title = "Delete"
            destination.saveButton.tintColor = .red
        }
    }
    
    @IBAction func unwindToStopList(sender: UIStoryboardSegue) {
        guard let sourceViewController = sender.source as? StopViewController, let stop = sourceViewController.stop else { return }
        let newIndexPath = IndexPath(row: stops.count, section: 0)
        if !stops.contains(where: { (elem) -> Bool in
            return elem.id == stop.id && elem.name == stop.name
        }) {
            stops.append(stop)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        } else {
            guard let idx = stops.firstIndex( where: { (elem) -> Bool in
                return elem.id == stop.id && elem.name == stop.name
            }) else { return }
            stops.remove(at: idx)
            tableView.deleteRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
        }
    }
    
}
