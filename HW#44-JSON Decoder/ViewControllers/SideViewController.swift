//
//  SideViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/4.
//

import UIKit

class SideViewController: UIViewController {
    
    let sideView: UIView = UIView()
    let servicesTableView: UITableView = UITableView()
    
    enum Constants {
        static let imageViewWidth: CGFloat = 60.0
        static let sideViewRadius: CGFloat = 20.0
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.sideVCWithTransparent
        
        setupUI()
    }
    
    func setupUI () {
        configureSideView()
        constraintSideView()
        
        delegateAndDataSource ()
        configureTableView()
        constraintServiceTableView()
        
        tapTheView()
    }
    
    func delegateAndDataSource () {
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
    }
    
    func configureTableView () {
        servicesTableView.register(FunctionsTableViewCell.self, forCellReuseIdentifier: FunctionsTableViewCell.identifier)
        servicesTableView.rowHeight = 55
        servicesTableView.separatorStyle = .none
        servicesTableView.allowsSelection = true
        
        servicesTableView.register(PersonalTableViewHeadView.self, forHeaderFooterViewReuseIdentifier: PersonalTableViewHeadView.identifier)
    }
    
    func constraintSideView() {
        view.addSubview(sideView)
        sideView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideView.topAnchor.constraint(equalTo: view.topAnchor),
            sideView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sideView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5 )
        ])
    }
    
    func constraintServiceTableView () {
        sideView.addSubview(servicesTableView)
        servicesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servicesTableView.topAnchor.constraint(equalTo: sideView.topAnchor),
            servicesTableView.leadingAnchor.constraint(equalTo: sideView.leadingAnchor),
            servicesTableView.trailingAnchor.constraint(equalTo: sideView.trailingAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: sideView.bottomAnchor),
        ])
    }
    
    func configureSideView() {
        sideView.backgroundColor    = Colors.white
        sideView.layer.cornerRadius = Constants.sideViewRadius
        sideView.clipsToBounds      = true
    }
    
    func tapTheView () {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedTheView))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tappedTheView () {
        self.dismiss(animated: true)
        print("DEBUG PRINT: tappedTheView")
    }
}

extension SideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesArray.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FunctionsTableViewCell.identifier, for: indexPath)
        let services = servicesArray[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        // Configure content.
        content.image = services.serviceImage
        content.text = services.serviceTitle
        
        content.imageProperties.tintColor = Colors.darkGray
        content.textProperties.color = Colors.lightGray
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: PersonalTableViewHeadView.identifier)
        return view
    }
}



#Preview {
    UINavigationController(rootViewController: SideViewController())
}
