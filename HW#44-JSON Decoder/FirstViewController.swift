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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView       ()
        delegateAndDataSource()
        constraintsTableView ()

    }
    
    func setupTableView () {
        tableView.register(YouBikeInfoTableViewCell.nib(), forCellReuseIdentifier: YouBikeInfoTableViewCell.identifier)
        tableView.rowHeight = 100
    }
    
    func delegateAndDataSource () {
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    func constraintsTableView () {
        tableView.backgroundColor = .blue
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
        
}

extension FirstViewController: UITableViewDelegate {
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouBikeInfoTableViewCell.identifier, for: indexPath) as? YouBikeInfoTableViewCell else { print(fatalError ())}
        
        cell.bikeQtyLabel.text         = "0"
        cell.leftoverBikeQtyLabel.text = "0"
        
        return cell
    }
}




extension Data {
    func prettyPrintedJSONString() {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let jsonData   = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
              let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to read JSON Object.")
            return
        }
        print(prettyJSONString)
    }
}

#Preview {
    UINavigationController(rootViewController: FirstViewController())
}
