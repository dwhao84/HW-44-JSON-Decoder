//
//  PersonalTableViewHeadView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/6.
//

import UIKit

class PersonalTableViewHeadView: UITableViewHeaderFooterView {
    
    static let identifier = "PersonalTableViewHeadView"
    
    let userPofileImageView: UIImageView = UIImageView()
    let userNameLabel: UILabel = UILabel()
    let phoneLabel: UILabel = UILabel()
    let currentCityLabel: UILabel = UILabel()
    
    let infoStackView: UIStackView = UIStackView()
    let stackView: UIStackView = UIStackView()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI ()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Unable to load the InformationView.")
    }

    func setupUI () {
        configureUserPofileImageView()
        configurePhoneLabel()
        configureCurrentCityLabel ()
        configureinfoStackView()
        configureStackView ()
        constraintStackView ()
    }
    
    func configureUserPofileImageView () {
        userPofileImageView.image = Images.person
        userPofileImageView.tintColor = Colors.lightGray
        userPofileImageView.contentMode = .scaleAspectFill
        userPofileImageView.layer.cornerRadius = 10
        userPofileImageView.clipsToBounds = true
    }
    
    func configurePhoneLabel () {
        phoneLabel.text = "09XX-123-456 "
        phoneLabel.textColor = Colors.lightGray
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        phoneLabel.numberOfLines = 0
        phoneLabel.textAlignment = .left
    }
    
    func configureCurrentCityLabel () {
        currentCityLabel.text = "Taipei City"
        currentCityLabel.textColor = Colors.systemYellow
        currentCityLabel.font = UIFont.systemFont(ofSize: 18)
        currentCityLabel.numberOfLines = 0
        currentCityLabel.textAlignment = .left
    }
    
    func configureinfoStackView () {
        infoStackView.axis = .vertical
        infoStackView.distribution = .fill
        infoStackView.spacing = 5
        infoStackView.alignment = .leading
        infoStackView.addArrangedSubview(phoneLabel)
        infoStackView.addArrangedSubview(currentCityLabel)
    }
    
    func configureStackView () {
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.alignment = .center
        stackView.addArrangedSubview(userPofileImageView)
        stackView.addArrangedSubview(infoStackView)
    }
    
    func constraintStackView () {
        userPofileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userPofileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
