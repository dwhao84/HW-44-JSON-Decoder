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
    let searchBar: UISearchBar = UISearchBar ()
    
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
        self.layer.cornerRadius = 20
        self.backgroundColor    = Colors.white
        configureListBtn()
        configureFavoriteBtn()
        configureSearchBar ()
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
    
    func configureSearchBar () {
        searchBar.delegate     = self
        searchBar.placeholder  = "Search station names"
        searchBar.isEnabled    = true
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.keyboardAppearance = .default
        self.addSubview(searchBar)
    }
    
    func configureSearchingStackView () {
        searchingStackView.axis         = .horizontal
        searchingStackView.alignment    = .center
        searchingStackView.distribution = .fill
        searchingStackView.spacing      = 0
        searchingStackView.addArrangedSubview(listBtn)
        searchingStackView.addArrangedSubview(searchBar)
        searchingStackView.addArrangedSubview(favoriteBtn)
        searchingStackView.addArrangedSubview(itemListBtn)
    }
    
    func constraintsSearchStackView () {
        
        searchBar.widthAnchor.constraint(equalToConstant: 200).isActive = true

        
        self.addSubview(searchingStackView)
        searchingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchingStackView.topAnchor.constraint(equalTo: self.topAnchor),
            searchingStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            searchingStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchingStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}

extension SearchView: UISearchBarDelegate {
    
}

#Preview (traits: .fixedLayout(width: 420, height: 60), body: {
    let searchView = SearchView()
    return searchView
})
