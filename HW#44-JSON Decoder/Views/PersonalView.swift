//
//  PersonalView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/6.
//

import UIKit

class PersonalView: UIView {
    
    let avartarImageView: UIImageView = UIImageView()
    let userNameLabel: UILabel = UILabel()
    let phoneLabel: UILabel = UILabel()
    let currentCityLabel: UILabel = UILabel()
    
    let infoStackView: UIStackView = UIStackView()
    let stackView: UIStackView = UIStackView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Unable to load the InformationView.")
    }

    func setupUI () {
        configureAvartarImageView()
        configurePhoneLabel()
        configureCurrentCityLabel ()
        configureinfoStackView()
        configureStackView ()
        constraintStackView ()
    }
    
    func configureAvartarImageView () {
        avartarImageView.image = Images.person
        avartarImageView.tintColor = Colors.lightGray
        avartarImageView.contentMode = .scaleAspectFill
        avartarImageView.layer.cornerRadius = 10
        avartarImageView.clipsToBounds = true
        self.addSubview(avartarImageView)
    }
    
    func configurePhoneLabel () {
        phoneLabel.text = "09XX-123-456 "
        phoneLabel.textColor = Colors.lightGray
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 20)
        phoneLabel.numberOfLines = 0
        phoneLabel.textAlignment = .left
        self.addSubview(phoneLabel)
    }
    
    func configureCurrentCityLabel () {
        currentCityLabel.text = "Taipei City"
        currentCityLabel.textColor = Colors.systemYellow
        currentCityLabel.font = UIFont.systemFont(ofSize: 18)
        currentCityLabel.numberOfLines = 0
        currentCityLabel.textAlignment = .left
        self.addSubview(currentCityLabel)
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
        stackView.addArrangedSubview(avartarImageView)
        stackView.addArrangedSubview(infoStackView)
    }
    
    func constraintStackView () {
        avartarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avartarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - Preview:
#Preview(traits: .fixedLayout(width: 256, height: 256*0.3), body: {
    let personalView = PersonalView()
    return personalView
})
