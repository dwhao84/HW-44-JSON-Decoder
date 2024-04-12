//
//  FavoriteListViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit
import CoreData

class FavoriteListViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<FavoriteListData>!
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteListDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    let favoriteListTableView: UITableView = UITableView()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // Save context by using Core data.
    let request: NSFetchRequest<FavoriteListData> = FavoriteListData.fetchRequest()
    
    private var modals = [FavoriteListData]()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEBUG PRINT: FavTableVC viewDidLoad")
        
        setupUI ()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("DEBUG PRINT: didReceiveMemoryWarning")
    }
    
    func loadFavoritePlaces () {
        do {
            modals = try context.fetch(request)
            favoriteListTableView.reloadData()
            print("DEBUG PRINT: 資料數\(modals.count)")
        } catch {
            print("DEBUG PRINT: Unable to fetch data.")
        }
        print(modals)
    }
    
    func setupUI () {
        configureFavoriteListTableView ()
        constraintsTableView()
        setupRefreshControl()
        loadFavoritePlaces()
        configureNC()
        
    }
    
    func configureNC () {
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkGray]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        appearance.backgroundColor = Colors.lightGray
        self.navigationController?.navigationBar.tintColor = Colors.systemYellow
        
        self.navigationItem.title = "Favorite Station List"
        self.view.backgroundColor = Colors.white
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
        favoriteListTableView.backgroundColor = Colors.white
        favoriteListTableView.dataSource = self
        favoriteListTableView.delegate   = self
        favoriteListTableView.rowHeight  = 100
        favoriteListTableView.register(FavoriteListTableViewCell.nib(), forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
        favoriteListTableView.frame = view.bounds
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

// MARK: - Extension:
extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Show the data which saved in modals by using Core data.
        modals.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListTableViewCell.identifier, for: indexPath) as? FavoriteListTableViewCell else {
            fatalError("DEBUG PRINT: Could not dequeue cell with identifier: \(FavoriteListTableViewCell.identifier)")
        }
        
        tableView.allowsSelection = true
        
        let place = modals[indexPath.row]
        cell.stationNameLabel.text = place.stationName
        cell.addressLabel.text = place.address
        cell.bikeQtyLabel.text = place.bikeQty
        cell.dockQtyLabel.text = place.dockQty
        
        print(place.address ?? "Can't find address.",
              place.stationName ?? "Can't find stationName",
              place.bikeQty ?? "Can't find bikeQty.",
              place.dockQty ?? "Can't find dockQty."
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            print("DEBUG PRINT: delete action tapped")
            
            // Performing batch delete operation
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteListData")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try self.context.execute(batchDeleteRequest)
                // Consider merging the following save with the above operation if not needed
                self.context.reset()
            } catch {
                print("Error \(error)")
            }

            // Re-fetch and update UI
            do {
                try self.fetchedResultsController?.performFetch()
                DispatchQueue.main.async {
                    // Reload the data and update the UI
                    self.favoriteListTableView.reloadData()
                }
            } catch {
                print("Failed to fetch entities after deletion: \(error)")
            }
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = Colors.red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true

        return configuration
    }
}



#Preview {
    UINavigationController(rootViewController: FavoriteListViewController())
}
