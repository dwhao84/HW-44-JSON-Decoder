import UIKit
import CoreData

class FavoriteListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<FavoriteListData>!
    
    var coreData: CoreDataStack = CoreDataStack()
    
    var managedObjectContext: NSManagedObjectContext!
    
    let favoriteListTableView: UITableView = UITableView()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = coreData.persistentContainer.viewContext
        
        setupUI()
        initializeFetchedResultsController()
    }
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<FavoriteListData> = FavoriteListData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "stationName", ascending: true)
        request.sortDescriptors = [sortDescriptor]

        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    func setupUI() {
        configureFavoriteListTableView()
        configureNavigationBar()
        setupRefreshControl()
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.lightGray
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.darkGray]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = Colors.systemYellow
        
        navigationItem.title = "Favorite Station List"
        view.backgroundColor = Colors.white
    }

    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        favoriteListTableView.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        favoriteListTableView.reloadData()
    }

    func configureFavoriteListTableView() {
        favoriteListTableView.backgroundColor = Colors.white
        favoriteListTableView.dataSource = self
        favoriteListTableView.delegate = self
        favoriteListTableView.rowHeight = 100
        favoriteListTableView.register(FavoriteListTableViewCell.nib(), forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
        favoriteListTableView.frame = view.bounds
        view.addSubview(favoriteListTableView)
        
        favoriteListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListTableViewCell.identifier, for: indexPath) as! FavoriteListTableViewCell
        configureCell(cell, at: indexPath)
        cell.backgroundColor = Colors.white
        return cell
    }

    func configureCell(_ cell: FavoriteListTableViewCell, at indexPath: IndexPath) {
        let favoriteListData = fetchedResultsController.object(at: indexPath)
        // 使用安全的可选链或提供默认值来避免崩溃
        cell.stationNameLabel?.text = favoriteListData.stationName ?? "Unknown Station"
        cell.addressLabel?.text = favoriteListData.address ?? "No Address"
        cell.bikeQtyLabel?.text = favoriteListData.bikeQty ?? "N/A"
        cell.dockQtyLabel?.text = favoriteListData.dockQty ?? "N/A"
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.deleteFavorite(at: indexPath)
            completionHandler(true)
        }
        deleteAction.backgroundColor = Colors.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func deleteFavorite(at indexPath: IndexPath) {
        let favoriteToDelete = fetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(favoriteToDelete)
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving context after deletion: \(error)")
        }
    }

    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.favoriteListTableView.reloadData()
        }
    }
}
