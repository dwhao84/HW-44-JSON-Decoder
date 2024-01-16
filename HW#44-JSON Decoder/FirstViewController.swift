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
        
        setTableView()
        setupNavigationItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: Set up TableView:
    func setTableView () {
        setupTableView()
        delegateAndDataSource()
        constraintsTableView()
    }
    
    func setupTableView () {
        tableView.register(YouBikeInfoTableViewCell.nib(), forCellReuseIdentifier: YouBikeInfoTableViewCell.identifier)
        tableView.rowHeight = 120
    }
    
    func delegateAndDataSource () {
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
    
    // MARK: Set up NavigationController
    func setupNavigationItem () {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "YouBike List"
        self.navigationItem.titleView?.backgroundColor = UIColorSelection.lightGray
    }
        
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YouBikeInfoTableViewCell.identifier, for: indexPath) as? YouBikeInfoTableViewCell else { fatalError ("Unable to dequeue Resuable Cell.") }

        cell.selectionStyle = .none
        
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
