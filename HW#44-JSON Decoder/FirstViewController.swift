//
//  FirstViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import UIKit

class FirstViewController: UIViewController {
    
    var stationNames = [Youbike]()
    
    let stationNameLabel: UILabel = UILabel()
    let tableView: UITableView = UITableView()
    
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
    }
    
    func setupTableView () {
        tableView.register(YouBikeInfoTableViewCell.nib(), forCellReuseIdentifier: YouBikeInfoTableViewCell.identifier)
        tableView.rowHeight = 120
        tableView.backgroundColor  = UIColorSelection.white
        tableView.allowsSelection  = true
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
// MARK: - Set up NavigationController
    func setupNavigationItem () {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "YouBike List"
        self.navigationItem.titleView?.backgroundColor = UIColorSelection.lightGray
    }
        
}

// MARK: - Extension UITableViewDelegate:
extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        
        let station = stationNames[indexPath.row]
        let mapVC = MapViewController()
        mapVC.lat = station.lat
        mapVC.lng = station.lng
        print("\(String(describing: mapVC.lat)) And \(String(describing: mapVC.lng))")
        self.navigationController?.pushViewController(mapVC, animated: true)
        
    }
}

// MARK: - Extension UITableViewDataSource:
extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(stationNames.count)
        return stationNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouBikeInfoTableViewCell.identifier, for: indexPath) as? YouBikeInfoTableViewCell else { fatalError ("Unable to dequeue Resuable Cell.") }
        
        let station = stationNames[indexPath.row]
        cell.youBikeStationName.text   = station.sna
        cell.leftoverBikeQtyLabel.text = String(station.sbi)
        cell.bikeQtyLabel.text         = String(station.bemp)
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return String
//    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColorSelection.brightGray
//    }
}


// TO DO: Preview
#Preview {
    UINavigationController(rootViewController: FirstViewController())
}
