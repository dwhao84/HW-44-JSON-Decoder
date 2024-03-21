//
//  SearchView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/19.
//

import UIKit

class SearchView: UIView {
    
    let listBtn: UIButton = UIButton(type: .system)
    let favoriteBtn: UIButton = UIButton(type: .system)
    let itemListBtn: UIButton = UIButton(type: .system)
    let searchController: UISearchController = UISearchController()
    
    let searchingStackView: UIStackView = UIStackView()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Unable to load the SearchView.")
    }
    
    // MARK: - Setup UI
    func setupUI () {
        self.layer.cornerRadius = 50
        configureListBtn()
        configureFavoriteBtn()
        configureItemListBtn()
        
        configureSearchingStackView()
        constraintsSearchStackView ()
    }

    func configureListBtn () {
        var config = UIButton.Configuration.plain()
        config.image = Images.listBullet
        config.baseForegroundColor = Colors.lightGray
        config.buttonSize = UIButton.Configuration.Size.large
        config.automaticallyUpdateForSelection = true
        listBtn.configuration = config
        self.addSubview(listBtn)
    }
    
    func configureFavoriteBtn () {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.yellow
        config.image = Images.starFill
        config.buttonSize = UIButton.Configuration.Size.large
        config.automaticallyUpdateForSelection = true
        favoriteBtn.configuration = config
        self.addSubview(favoriteBtn)
    }
    
    func configureItemListBtn () {
        var config = UIButton.Configuration.plain()
        config.image = Images.listStar
        config.baseForegroundColor = Colors.lightGray
        config.buttonSize = UIButton.Configuration.Size.large
        config.automaticallyUpdateForSelection = true
        itemListBtn.configuration = config
        self.addSubview(itemListBtn)
    }
    
    func configureSearchingStackView () {
        searchingStackView.axis         = .horizontal
        searchingStackView.alignment    = .center
        searchingStackView.distribution = .fillEqually
        searchingStackView.spacing      = 100
        searchingStackView.addArrangedSubview(listBtn)
        searchingStackView.addArrangedSubview(favoriteBtn)
        searchingStackView.addArrangedSubview(itemListBtn)
    }
    
    func constraintsSearchStackView () {
        
        itemListBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        favoriteBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        listBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addSubview(searchingStackView)
        searchingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchingStackView.topAnchor.constraint(equalTo: self.topAnchor),
            searchingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

#Preview (traits: .fixedLayout(width: 420, height: 60), body: {
    let searchView = SearchView()
    return searchView
})
