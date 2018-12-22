//
//  SearchViewController.swift
//  omatpysakit
//
//  Created by Essi Jukkala on 22/12/2018.
//  Copyright © 2018 Essi Jukkala. All rights reserved.
//

import UIKit
import Apollo

class SearchViewController: UITableViewController {
    var allStops: [Stop] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStops()
    }
    
    func getAllStops() {
        allStops = []
        staticApollo.apollo.fetch(query: AllStopsQuery()) { [weak self]
            (result, error) in
            guard let sSelf = self, let result = result, let data = result.data, let stops = data.stops else { print(error!); return }
            stops.forEach{
                guard let name = $0?.name, let id = $0?.gtfsId else { return }
                let stop = Stop(name: name, id: id)
                sSelf.allStops.append(stop)
            }
            sSelf.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.name.text = allStops[indexPath.row].name
        cell.stop = allStops[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil && segue.identifier! == "AddStop" {
            guard let navigation = segue.destination as? UINavigationController else { return }
            guard let destination = navigation.viewControllers.first as? StopViewController else { return }
            guard let sender = sender as? SearchCell, let stop = sender.stop else { return }
            destination.stop = stop
        }
    }
}
