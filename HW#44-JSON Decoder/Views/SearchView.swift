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
    let searchTextField: UITextField = UITextField()
    
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
        configureItemListBtn()
        configureSearchTextField ()
        
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
    
    func configureSearchTextField () {
        searchTextField.delegate           = self
        searchTextField.placeholder        = "Search Stations"
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds      = true
        searchTextField.borderStyle        = .none
        searchTextField.leftView           = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.returnKeyType = .go
        self.addSubview(searchTextField)
    }
    
    func configureSearchingStackView () {
        searchingStackView.axis         = .horizontal
        searchingStackView.alignment    = .center
        searchingStackView.distribution = .fill
        searchingStackView.spacing      = 0
        searchingStackView.addArrangedSubview(listBtn)
        searchingStackView.addArrangedSubview(searchTextField)
        searchingStackView.addArrangedSubview(favoriteBtn)
        searchingStackView.addArrangedSubview(itemListBtn)
    }
    
    func constraintsSearchStackView () {
        searchTextField.widthAnchor.constraint(equalToConstant: 210).isActive = true
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

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder()
            
        }
        return true
    }
}

#Preview (traits: .fixedLayout(width: 420, height: 60), body: {
    let searchView = SearchView()
    return searchView
})
