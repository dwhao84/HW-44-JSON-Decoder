//
//  InformationView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/17.
//

import UIKit

class InformationView: UIView {
    
    static let informationView: UIView = UIView()
    
    var bikeCycleImage: UIImageView = UIImageView()
    
    var stationNameLabel: UILabel   = UILabel()
    var addressLabel: UILabel       = UILabel()
    var bikeVacanciesLabel: UILabel = UILabel()
    var distanceLabel: UILabel      = UILabel()
    var updateTimeLabel: UILabel    = UILabel()
    
    let routeButton: UIButton    = UIButton(type: .system)
    let favoriteButton: UIButton = UIButton(type: .system)
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupUI()
    }
    
    // MARK: - Beginning
    func setupUI () {
        self.backgroundColor = Colors.black
        self.alpha           = 0.8
        

        configureStationNameLabel ()
        configureAddressLabel  ()
        configureDistanceLabel    ()
        configureUpdateTimeLabel ()
        
        configureRouteButton()
        configureFavoriteButton ()
    }
    

    
    func configureStationNameLabel () {
        stationNameLabel.frame                     = CGRect(x: 10, y: 50, width: 200, height: 20)
        stationNameLabel.text                      = "復興南路二段235號前"
        stationNameLabel.textColor                 = Colors.lightGray
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
        distanceLabel.textColor                    = Colors.lightGray
        distanceLabel.font                         = UIFont.systemFont(ofSize: 9)
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
        routeButton.frame                 = CGRect(x: 180, y: 80, width: 85, height: 30)
        self.addSubview(routeButton)
    }
    
    func configureFavoriteButton () {
        favoriteButton.frame              = CGRect(x: 270, y: 80, width: 80, height: 30)
//        favoriteButton.setTitleColor(Colors.white, for: .normal)
//        favoriteButton.setTitle("Favorite", for: .normal)
//        favoriteButton.titleLabel?.font   = UIFont.systemFont(ofSize: 5)
//        favoriteButton.backgroundColor    = Colors.systemYellow
//        favoriteButton.setImage(Images.starFill, for: .normal)
//        favoriteButton.imageView?.contentMode = .scaleAspectFits
//        favoriteButton.layer.cornerRadius = FavoriteButtonSize.width / 2
        self.addSubview(favoriteButton)
    }
    

    
    func constraintsComponents () {
        routeButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.widthAnchor.constraint(equalToConstant: FavoriteButtonSize.width).isActive   = true
        favoriteButton.heightAnchor.constraint(equalToConstant: FavoriteButtonSize.height).isActive = true
        routeButton.widthAnchor.constraint(equalToConstant: RouteButtonSize.width).isActive         = true
        routeButton.heightAnchor.constraint(equalToConstant: RouteButtonSize.height).isActive       = true
        
        
        
    }
    
}

// MARK: - Preview:
#Preview(traits: .fixedLayout(width: 360, height: 120), body: {
    let informationView = InformationView()
    return informationView
})
