//
//  SideViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/4.
//

import UIKit

class SideViewController: UIViewController {
    
    let personalView: PersonalView = PersonalView()
    
    let sideView: UIView = UIView()
    let functionsTableView: UITableView = UITableView()
    
    let data: [String] = [
        "登入資訊",
        "最愛清單",
    ]
    
    enum Constants {
        static let imageViewWidth: CGFloat = 60.0
        static let sideViewRadius: CGFloat = 20
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
        constraintPersonalView ()
        
    }
    
    func delegateAndDataSource () {
        functionsTableView.delegate = self
        functionsTableView.dataSource = self
    }
    
    func constraintPersonalView () {
        sideView.addSubview(personalView)
        personalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personalView.topAnchor.constraint(equalTo: sideView.topAnchor, constant: 30),
            personalView.leadingAnchor.constraint(equalTo: sideView.leadingAnchor),
            personalView.trailingAnchor.constraint(equalTo: sideView.trailingAnchor),
            personalView.heightAnchor.constraint(equalTo: sideView.widthAnchor, multiplier: 0.3)
        ])
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
    
    func configureSideView() {
        sideView.backgroundColor    = Colors.white
        sideView.layer.cornerRadius = Constants.sideViewRadius
        sideView.clipsToBounds      = true
    }
}

extension SideViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}



#Preview {
    UINavigationController(rootViewController: SideViewController())
}
