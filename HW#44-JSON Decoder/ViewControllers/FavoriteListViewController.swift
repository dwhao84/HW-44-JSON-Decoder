//
//  FavoriteListViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let dataArray: [String]    = [""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight  = 50
        
        constraintsTableView()
        
    }

    func constraintsTableView () {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension FavoriteListViewController: UITableViewDelegate {
    
}

extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        UITableViewCell ()
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: FavoriteListViewController())
}
