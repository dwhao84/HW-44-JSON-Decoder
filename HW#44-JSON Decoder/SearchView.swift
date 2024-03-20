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

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    func setupUI () {
        self.layer.cornerRadius = 50
    }

    func configureListBtn () {
        
    }
    
    func configureFavoriteBtn () {
        
    }
    
    func configureItemListBtn () {
        
    }
}

#Preview (traits: .fixedLayout(width: 420, height: 80), body: {
    let searchView = SearchView()
    return searchView
})
