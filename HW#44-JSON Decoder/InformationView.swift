//
//  InformationView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/17.
//

import UIKit

class InformationView: UIView {
    
    static let informationView: UIView = UIView()
    
    let bikeImageView: UIImageView  = UIImageView()
    let docksImageView: UIImageView = UIImageView()
    let bikeLabel: UILabel  = UILabel()
    let docksLabel: UILabel = UILabel()
    
    var bikeQtyLabel: UILabel = UILabel()
    var dockQtyLabel: UILabel = UILabel()
    
    var stationNameLabel: UILabel   = UILabel()
    var addressLabel: UILabel       = UILabel()
    var bikeVacanciesLabel: UILabel = UILabel()
    var distanceLabel: UILabel      = UILabel()
    var updateTimeLabel: UILabel    = UILabel()
        
    let routeButton: UIButton    = UIButton(type: .system)
    let favoriteButton: UIButton = UIButton(type: .system)
    
    let bikeStackView: UIStackView = UIStackView()
    let dockStackView: UIStackView = UIStackView()
    
    let buttonStackView: UIStackView = UIStackView()
    let labelsStackView: UIStackView = UIStackView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Beginning
    func setupUI () {
        self.backgroundColor = Colors.black
        self.alpha           = 0.8
        
        configureBikeQtyLabel()
        configureDockQtyLabel()
        
        configureBikeLabel()
        configureDocksLabel ()
        configureBikeImageView()
        configureParkingSignImageView ()
        
        configureStationNameLabel ()
        configureAddressLabel  ()
        configureDistanceLabel    ()
        configureUpdateTimeLabel ()
        configureRouteButton()
        configureFavoriteButton ()
        
        configureButtonStackView()
        
        
        constraintsButtonStackView()
    }
    
    func configureBikeImageView () {
        bikeImageView.frame = CGRect(x: 10, y: 15, width: 20, height: 20)
        bikeImageView.image = Images.bike
        bikeImageView.tintColor = Colors.lightGray
        bikeImageView.contentMode = .scaleAspectFit
        self.addSubview(bikeImageView)
    }
    
    func configureParkingSignImageView () {
        docksImageView.frame = CGRect(x: 66, y: 15, width: 20, height: 20)
        docksImageView.image = Images.parkingSign
        docksImageView.tintColor = Colors.lightGray
        docksImageView.contentMode = .scaleAspectFit
        self.addSubview(docksImageView)
    }
    
    func configureBikeQtyLabel () {
        bikeQtyLabel.frame                     = CGRect(x: 42, y: 29, width: 200, height: 20)
        bikeQtyLabel.text                      = "0"
        bikeQtyLabel.textColor                 = Colors.lightGray
        bikeQtyLabel.font                      = UIFont.boldSystemFont(ofSize: 15)
        bikeQtyLabel.numberOfLines             = 0
        bikeQtyLabel.textAlignment             = .left
        bikeQtyLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(bikeQtyLabel)
    }
    
    func configureDockQtyLabel () {
        dockQtyLabel.frame                     = CGRect(x: 100, y: 29, width: 200, height: 20)
        dockQtyLabel.text                      = "0"
        dockQtyLabel.textColor                 = Colors.lightGray
        dockQtyLabel.font                      = UIFont.boldSystemFont(ofSize: 15)
        dockQtyLabel.numberOfLines             = 0
        dockQtyLabel.textAlignment             = .left
        dockQtyLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(dockQtyLabel)
    }
    
    func configureBikeLabel () {
        bikeLabel.frame                     = CGRect(x: 10, y: 32, width: 200, height: 20)
        bikeLabel.text                      = "Bikes"
        bikeLabel.textColor                 = Colors.lightGray
        bikeLabel.font                      = UIFont.systemFont(ofSize: 8)
        bikeLabel.numberOfLines             = 0
        bikeLabel.textAlignment             = .left
        bikeLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(bikeLabel)
    }
    
    func configureDocksLabel () {
        docksLabel.frame                     = CGRect(x: 65, y: 32, width: 200, height: 20)
        docksLabel.text                      = "Docks"
        docksLabel.textColor                 = Colors.lightGray
        docksLabel.font                      = UIFont.systemFont(ofSize: 8)
        docksLabel.numberOfLines             = 0
        docksLabel.textAlignment             = .left
        docksLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(docksLabel)
    }
    
    func configureStationNameLabel () {
        stationNameLabel.frame                     = CGRect(x: 10, y: 50, width: 200, height: 20)
        stationNameLabel.text                      = "復興南路二段235號前"
        stationNameLabel.textColor                 = Colors.white
        stationNameLabel.font                      = UIFont.boldSystemFont(ofSize: 10)
        stationNameLabel.numberOfLines             = 0
        stationNameLabel.textAlignment             = .left
        stationNameLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(stationNameLabel)
    }
    
    func configureAddressLabel () {
        addressLabel.frame                         = CGRect(x: 10, y: 70, width: 100, height: 15)
        addressLabel.text                          = "復興南路二段235號前"
        addressLabel.textColor                     = Colors.lightGray
        addressLabel.font                          = UIFont.systemFont(ofSize: 9)
        addressLabel.numberOfLines                 = 0
        addressLabel.textAlignment                 = .left
        addressLabel.adjustsFontSizeToFitWidth     = true
        self.addSubview(addressLabel)
    }
    
    func configureDistanceLabel () {
        distanceLabel.frame                        = CGRect(x: 10, y: 85, width: 100, height: 15)
        distanceLabel.text                         = "165m"
        distanceLabel.textColor                    = Colors.white
        distanceLabel.font                         = UIFont.boldSystemFont(ofSize: 9)
        distanceLabel.numberOfLines                = 0
        distanceLabel.textAlignment                = .left
        distanceLabel.adjustsFontSizeToFitWidth    = true
        self.addSubview(distanceLabel)
    }
    
    func configureUpdateTimeLabel () {
        updateTimeLabel.frame                     = CGRect(x: 10, y: 100, width: 100, height: 15)
        updateTimeLabel.text                      = "Update 23:00"
        updateTimeLabel.textColor                 = Colors.lightGray
        updateTimeLabel.font                      = UIFont.systemFont(ofSize: 8)
        updateTimeLabel.numberOfLines             = 0
        updateTimeLabel.textAlignment             = .left
        updateTimeLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(updateTimeLabel)
    }
    
    func configureRouteButton () {
        var title = AttributedString("Route")
        title.font = UIFont.boldSystemFont(ofSize: 10)
        
        var config                        = UIButton.Configuration.filled()
        config.cornerStyle                = .large
        config.attributedTitle            = title
        config.image                      = Images.arrowTurnUpRight
        config.imagePlacement             = .leading
        config.imagePadding               = 5
        config.buttonSize                 = UIButton.Configuration.Size.mini
        config.baseForegroundColor        = Colors.darkGray
        config.background.backgroundColor = Colors.white
        routeButton.configuration         = config
        routeButton.frame                 = CGRect(x: 180, y: 83, width: 80, height: 30)
        self.addSubview(routeButton)
        routeButton.addTarget(self, action: #selector(routeBtnTapped), for: .touchUpInside)
    }
    
    func configureFavoriteButton () {
        favoriteButton.frame              = CGRect(x: 270, y: 83, width: 80, height: 30)
        favoriteButton.tintColor = Colors.white
        favoriteButton.setTitle("Favorite", for: .normal)
        favoriteButton.titleLabel?.font   = UIFont.systemFont(ofSize: 10)
        favoriteButton.backgroundColor    = Colors.systemYellow
        favoriteButton.setImage(Images.starFill, for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16), forImageIn: .normal)
        favoriteButton.layer.cornerRadius = FavoriteButtonSize.width / 3
        self.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)
    }
    
    func configureButtonStackView () {
        buttonStackView.axis      = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.spacing   = 10
        buttonStackView.distribution = .fill
        buttonStackView.addArrangedSubview(routeButton)
        buttonStackView.addArrangedSubview(favoriteButton)
    }
    
    func configureLabelsStackView () {
        
    }
    
    
    // MARK: - Actions:
    @objc func routeBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: routeBtnTapped")
    }
    
    @objc func favoriteBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: favoriteBtnTapped")
    }

    // MARK: - Layout Constraints:
    func constraintsButtonStackView () {
        self.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            routeButton.widthAnchor.constraint(equalToConstant: 80),
            routeButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 80),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}

// MARK: - Preview:
#Preview(traits: .fixedLayout(width: 360, height: 120), body: {
    let informationView = InformationView()
    return informationView
})
