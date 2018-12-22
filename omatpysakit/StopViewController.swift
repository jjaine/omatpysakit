//
//  ViewController.swift
//  omatpysakit
//
//  Created by Essi Jukkala on 21/12/2018.
//  Copyright © 2018 Essi Jukkala. All rights reserved.
//

import UIKit
import Apollo

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
        let minutes = (Int(self) / 60) % 60
        let seconds = Int(self) % 60
        return String(format: "%d min", minutes)
    }
}

struct LineInfo {
    let name: String
    let arrivalTime: Date
}

class StopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stopName: UILabel!
    var info: [LineInfo] = []
    var timer: Timer? = nil
    var id: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStopInfo()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self]
            (_) in
            self?.getStopInfo()
            })
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func getStopInfo() {
        info = []
        guard let id = id else { return }
        staticApollo.apollo.fetch(query: StopInfoQuery(id: id)) { [weak self]
            (result, error) in
            guard let sSelf = self, let result = result, let data = result.data, let stop = data.stop else { print(error!); return }
            stop.stoptimesWithoutPatterns?.forEach{
                let name = $0!.trip!.routeShortName! + " (" + $0!.trip!.tripHeadsign! + ")"
                let arrivalTimeUnix: Int
                if let realtimeArrival = $0!.realtimeArrival {
                    arrivalTimeUnix = $0!.serviceDay!+realtimeArrival
                } else {
                    arrivalTimeUnix = $0!.serviceDay!+$0!.scheduledArrival!
                }
                let arrivalTimeDate = Date(timeIntervalSince1970: TimeInterval(arrivalTimeUnix))
                
                let info = LineInfo(name: name, arrivalTime: arrivalTimeDate)
                sSelf.info.append(info)
            }
            sSelf.stopName.text = stop.name
            sSelf.tableView.reloadData()
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopInfoCell") as! StopInfoCell
        cell.lineName.text = info[indexPath.row].name
        let timeToArrival = info[indexPath.row].arrivalTime.timeIntervalSinceNow
        cell.arrival.text = timeToArrival.stringFormatted()
        return cell
    }
}

