//
//  FavoriteListViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit
import CoreData

class FavoriteListViewController: UIViewController {
    
    let favoriteListTableView: UITableView = UITableView()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // Save context by using Core data.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var modals = [FavoriteListData]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    func setupUI () {
        configureFavoriteListTableView ()
        constraintsTableView()
        setupRefreshControl()
    }
    
    // MARK: - Refresh Control
    func setupRefreshControl () {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        favoriteListTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        favoriteListTableView.reloadData()
    }
    
    // MARK: - Favorite List TableView
    func configureFavoriteListTableView () {
        favoriteListTableView.dataSource = self
        favoriteListTableView.delegate   = self
        favoriteListTableView.rowHeight  = 100
        favoriteListTableView.register(FavoriteListTableViewCell.self, forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
        self.navigationItem.title = "Favorite List"
    }
    
    func constraintsTableView () {
        view.addSubview(favoriteListTableView)
        favoriteListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Core data
    
    func getAllItems () {
        do {
            modals = try context.fetch(FavoriteListData.fetchRequest())
            DispatchQueue.main.async {
                self.favoriteListTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    func createItem(address: String, bikeQty: String, dockQty: String) {
        let newItem = FavoriteListData(context: context)
        newItem.address = address
        newItem.bikeQty = bikeQty
        newItem.dockQty = dockQty
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteItem(item: FavoriteListData) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func updateItem(item: FavoriteListData, newName: String) {
        item.stationName = String()
        item.dockQty = String()
        item.bikeQty = String()
        item.address = String()
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

// MARK: - Extension:
extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListTableViewCell.identifier, for: indexPath)
//        let model = modals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "刪除") { (action, view, completionHandler) in
            print("刪除內容")
            completionHandler(false)
        }
        
        deleteAction.backgroundColor = Colors.red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // 防止滑到底觸發第一個 button 的 action
        
        return configuration
    }
}

#Preview {
    UINavigationController(rootViewController: FavoriteListViewController())
}
