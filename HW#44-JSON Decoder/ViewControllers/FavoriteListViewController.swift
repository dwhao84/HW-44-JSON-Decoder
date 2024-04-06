//
//  FavoriteListViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    let favoriteListTableView: UITableView = UITableView()
    
    var dataArray: [String] = [""]
    
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
    }
    
    func configureFavoriteListTableView () {
        favoriteListTableView.dataSource = self
        favoriteListTableView.delegate   = self
        favoriteListTableView.rowHeight  = 120
        
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
    
}

extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        UITableViewCell ()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "刪除") { (action, view, completionHandler) in
            print("一點點不動心")
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
