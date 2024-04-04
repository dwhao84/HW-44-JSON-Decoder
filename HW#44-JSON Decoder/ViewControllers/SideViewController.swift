//
//  SideViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/4.
//

import UIKit

class SideViewController: UIViewController {
    
    let favoriteBtn: UIButton = UIButton(type: .system)
    let loginBtn: UIButton    = UIButton(type: .system)
    let sideView: UIView      = UIView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.sideVCWithTransparent
        
        var config = UIButton.Configuration.plain()
        var title = AttributedString("Favorite List")
        title.foregroundColor = UIColor.darkGray
        title.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedTitle = title
        config.automaticallyUpdateForSelection = true
        config.titleAlignment = .center
        favoriteBtn.configuration = config
        
        sideView.backgroundColor    = Colors.white
        sideView.layer.cornerRadius = 20
        sideView.clipsToBounds      = true
        
        view.addSubview(sideView)
        sideView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideView.topAnchor.constraint(equalTo: view.topAnchor),
            sideView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sideView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/5 )
        ])
        
        sideView.addSubview(favoriteBtn)
        favoriteBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteBtn.topAnchor.constraint(equalTo: sideView.topAnchor, constant: 50),
            favoriteBtn.centerXAnchor.constraint(equalTo: sideView.centerXAnchor)
        ])
        
    }
    
    

    
}

#Preview {
    UINavigationController(rootViewController: SideViewController())
}
