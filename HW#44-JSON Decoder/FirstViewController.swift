//
//  FirstViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import UIKit

class FirstViewController: UIViewController {
    
    struct Section {
        let title:    String
        let stations: [Youbike]
    }
    
    struct Coordinates {
        let lat: Double
        let lng: Double
    }
    
    var sections     = [Section]()
    var stationNames = [Youbike]()
    
    let stationNameLabel: UILabel = UILabel()
    let tableView: UITableView = UITableView()
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    var latitude:   Int?
    var longtitude: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setupNavigationItem()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchData() {
        if let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Network request error: \(error)")
                    return
                }
                if let data = data {
                    do {
                        let stations = try JSONDecoder().decode([Youbike].self, from: data)
                        DispatchQueue.main.async {
                            self.stationNames = stations
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("JSON decoding error: \(error)")
                    }
                }
            }.resume()
        }
    }

// MARK: - Set up TableView:
    func setTableView () {
        setupTableView()
        setTableViewDelegateAndDataSource()
        constraintsTableView()
        setupRefreshControl()
    }
    
    func setupTableView () {
        tableView.register(YouBikeInfoTableViewCell.nib(), forCellReuseIdentifier: YouBikeInfoTableViewCell.identifier)
        tableView.rowHeight = 120
    }
    
    func setTableViewDelegateAndDataSource () {
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    func constraintsTableView () {
        tableView.backgroundColor = UIColorSelection.white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
// MARK: - Set up NavigationController
    func setupNavigationItem () {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "YouBike List"
        self.navigationController?.navigationBar.barTintColor = UIColorSelection.white
    }
// MARK: - Refresh Control
    func setupRefreshControl () {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        tableView.reloadData        ()
       }
}

// MARK: - Extension UITableViewDelegate:
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        
        let selectedStation = stationNames[indexPath.row]
        let mapVC = MapViewController()
        mapVC.selectedStation = selectedStation
        present(mapVC, animated: true)
        
        // print out selected row's infomation data.
        // And trying to pass the data to mapVC.
        print(stationNames[indexPath.row])
    }
}

// MARK: - Extension UITableViewDataSource:
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(stationNames.count)
        return stationNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue Reusable Cell.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouBikeInfoTableViewCell.identifier, for: indexPath) as? YouBikeInfoTableViewCell else { fatalError ("Unable to dequeue Resuable Cell.") }
        
        let station = stationNames[indexPath.row]
        
        // Modified station name removed the "YouBike2.0_"
        var modifiedStationName = station.sna
        modifiedStationName = station.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        
        // Updated the leftoverBikeQtyLabel text, if sbi under 2.
        if station.sbi < 2 {
            cell.leftoverBikeQtyLabel.textColor = UIColorSelection.red
        } else {
            cell.leftoverBikeQtyLabel.textColor = UIColorSelection.black
        }
        
        cell.youBikeStationName.text = modifiedStationName
        cell.bikeQtyLabel.text       = String(station.bemp)
        cell.timeLabel.text          = station.srcUpdateTime
        cell.selectionStyle          = .default
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return stationNames[indexPath ?? 0].sarea
//    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColorSelection.brightGray
    }
}

// MARK: - Preview function.
#Preview {
    UINavigationController(rootViewController: FirstViewController())
}
