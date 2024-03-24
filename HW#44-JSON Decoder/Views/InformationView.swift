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
    
    let bikeStatusStackView: UIStackView = UIStackView()
    
    let buttonStackView: UIStackView = UIStackView()
    let labelsStackView: UIStackView = UIStackView()
    
    
    let contentStackView: UIStackView = UIStackView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Unable to load the InformationView.")
    }
    
    // MARK: - Functions
    func setupUI () {
        self.backgroundColor = Colors.black
        self.alpha           = 0.88
        
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
        
        configureBikeStackView()
        configureDockStackView ()
        
        configureButtonStackView()
        configureLabelsStackView ()
        
        configureBikeStatusStackView ()
        configureContentStackView ()
        
        constraintsButtonStackView()
        constraintsBikeStatusStackView ()
    }
    
    func configureBikeImageView () {
        bikeImageView.image = Images.bike
        bikeImageView.tintColor = Colors.lightGray
        bikeImageView.contentMode = .scaleAspectFit
        self.addSubview(bikeImageView)
    }
    
    func configureParkingSignImageView () {
        docksImageView.image = Images.parkingSign
        docksImageView.tintColor = Colors.lightGray
        docksImageView.contentMode = .scaleAspectFit
        self.addSubview(docksImageView)
    }
    
    func configureBikeQtyLabel () {
        bikeQtyLabel.text                      = "0"
        bikeQtyLabel.textColor                 = Colors.lightGray
        bikeQtyLabel.font                      = UIFont.boldSystemFont(ofSize: 15)
        bikeQtyLabel.numberOfLines             = 0
        bikeQtyLabel.textAlignment             = .left
        bikeQtyLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(bikeQtyLabel)
    }
    
    func configureDockQtyLabel () {
        dockQtyLabel.text                      = "0"
        dockQtyLabel.textColor                 = Colors.lightGray
        dockQtyLabel.font                      = UIFont.boldSystemFont(ofSize: 15)
        dockQtyLabel.numberOfLines             = 0
        dockQtyLabel.textAlignment             = .left
        dockQtyLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(dockQtyLabel)
    }
    
    func configureBikeLabel () {
        bikeLabel.text                      = "Bikes"
        bikeLabel.textColor                 = Colors.lightGray
        bikeLabel.font                      = UIFont.systemFont(ofSize: 8)
        bikeLabel.numberOfLines             = 0
        bikeLabel.textAlignment             = .left
        bikeLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(bikeLabel)
    }
    
    func configureDocksLabel () {
        docksLabel.text                      = "Docks"
        docksLabel.textColor                 = Colors.lightGray
        docksLabel.font                      = UIFont.systemFont(ofSize: 8)
        docksLabel.numberOfLines             = 0
        docksLabel.textAlignment             = .left
        docksLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(docksLabel)
    }
    
    func configureStationNameLabel () {
        stationNameLabel.text                      = "復興南路二段235號前"
        stationNameLabel.textColor                 = Colors.white
        stationNameLabel.font                      = UIFont.boldSystemFont(ofSize: 12)
        stationNameLabel.numberOfLines             = 0
        stationNameLabel.textAlignment             = .left
        stationNameLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(stationNameLabel)
    }
    
    func configureAddressLabel () {
        addressLabel.text                          = "復興南路二段235號前"
        addressLabel.textColor                     = Colors.lightGray
        addressLabel.font                          = UIFont.systemFont(ofSize: 9)
        addressLabel.numberOfLines                 = 0
        addressLabel.textAlignment                 = .left
        addressLabel.adjustsFontSizeToFitWidth     = true
        self.addSubview(addressLabel)
    }
    
    func configureDistanceLabel () {
        distanceLabel.text                         = "165m"
        distanceLabel.textColor                    = Colors.white
        distanceLabel.font                         = UIFont.boldSystemFont(ofSize: 10)
        distanceLabel.numberOfLines                = 0
        distanceLabel.textAlignment                = .left
        distanceLabel.adjustsFontSizeToFitWidth    = true
        self.addSubview(distanceLabel)
    }
    
    func configureUpdateTimeLabel () {
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
        //        routeButton.frame                 = CGRect(x: 180, y: 83, width: 80, height: 30)
        self.addSubview(routeButton)
        routeButton.addTarget(self, action: #selector(routeBtnTapped), for: .touchUpInside)
    }
    
    func configureFavoriteButton () {
        favoriteButton.tintColor = Colors.white
        favoriteButton.setTitle("Favorite", for: .normal)
        favoriteButton.titleLabel?.font   = UIFont.systemFont(ofSize: 10)
        favoriteButton.backgroundColor    = Colors.yellow
        favoriteButton.setImage(Images.starFill, for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 16), forImageIn: .normal)
        favoriteButton.layer.cornerRadius = FavoriteButtonSize.width / 3
        self.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)
    }
    
    func configureBikeStackView () {
        bikeStackView.axis = .vertical
        bikeStackView.alignment = .center
        bikeStackView.spacing   = 5
        bikeStackView.distribution = .fill
        bikeStackView.addArrangedSubview(bikeImageView)
        bikeStackView.addArrangedSubview(bikeLabel)
    }
    
    func configureDockStackView () {
        dockStackView.axis = .vertical
        dockStackView.alignment = .center
        dockStackView.spacing   = 5
        dockStackView.distribution = .fill
        dockStackView.addArrangedSubview(docksImageView)
        dockStackView.addArrangedSubview(docksLabel)
    }
    
    func configureBikeStatusStackView () {
        bikeStatusStackView.axis = .horizontal
        bikeStatusStackView.alignment = .lastBaseline
        bikeStatusStackView.spacing = 6
        bikeStatusStackView.distribution = .fillEqually
        bikeStatusStackView.addArrangedSubview(bikeStackView)
        bikeStatusStackView.addArrangedSubview(bikeQtyLabel)
        bikeStatusStackView.addArrangedSubview(dockStackView)
        bikeStatusStackView.addArrangedSubview(dockQtyLabel)
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
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.spacing      = 3
        labelsStackView.addArrangedSubview(stationNameLabel)
        labelsStackView.addArrangedSubview(addressLabel)
        labelsStackView.addArrangedSubview(distanceLabel)
        labelsStackView.addArrangedSubview(updateTimeLabel)
    }
    
    func configureContentStackView () {
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing      = 2
        contentStackView.addArrangedSubview(bikeStatusStackView)
        contentStackView.addArrangedSubview(labelsStackView)
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
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
            routeButton.widthAnchor.constraint(equalToConstant: 80),
            routeButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 80),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func constraintsBikeStatusStackView () {
        stationNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 10).isActive     = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 15).isActive    = true
        updateTimeLabel.heightAnchor.constraint(equalToConstant: 10).isActive  = true
        
        bikeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bikeImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        docksImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        docksImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bikeQtyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dockQtyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bikeLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        docksLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true

        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
        ])
    }
    
}

// MARK: - Preview:
#Preview(traits: .fixedLayout(width: 420, height: 140), body: {
    let informationView = InformationView()
    return informationView
})
