//
//  FavoriteListTableViewCell.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/7.
//

import UIKit

class FavoriteListTableViewCell: UITableViewCell {
    
    static let identifier = "FavoriteListTableViewCell"

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var bikeImageView: UIImageView!
    @IBOutlet weak var dockImageView: UIImageView!
    @IBOutlet weak var bikeQtyLabel: UILabel!
    @IBOutlet weak var dockQtyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let bikeStackView: UIStackView = UIStackView()
    let contentStackView: UIStackView = UIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureLabel()
        configureImageView()
        configureStackView()
        self.backgroundColor = Colors.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("DEBUG PRINT: prepareForReuse")
    }
    
    func configureStackView () {
        bikeImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bikeImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dockImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dockImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        bikeQtyLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        bikeQtyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dockQtyLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dockQtyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bikeStackView.axis = .horizontal
        bikeStackView.distribution = .fill
        bikeStackView.alignment = .center
        bikeStackView.spacing = 5
        bikeStackView.addArrangedSubview(bikeImageView)
        bikeStackView.addArrangedSubview(bikeQtyLabel)
        bikeStackView.addArrangedSubview(dockImageView)
        bikeStackView.addArrangedSubview(dockQtyLabel)
        bikeStackView.addArrangedSubview(addressLabel)
        
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.alignment = .leading
        contentStackView.spacing = 5
        contentStackView.addArrangedSubview(stationNameLabel)
        contentStackView.addArrangedSubview(bikeStackView)
        
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func configureLabel () {
        stationNameLabel.text = "0"
        stationNameLabel.textColor = Colors.darkGray
        stationNameLabel.textAlignment = .center
        stationNameLabel.numberOfLines = 0
        stationNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        bikeQtyLabel.text = "0"
        bikeQtyLabel.textColor = Colors.darkGray
        bikeQtyLabel.textAlignment = .center
        bikeQtyLabel.numberOfLines = 0
        bikeQtyLabel.font = UIFont.systemFont(ofSize: 15)
        
        dockQtyLabel.text = "0"
        dockQtyLabel.textColor = Colors.darkGray
        dockQtyLabel.textAlignment = .center
        dockQtyLabel.numberOfLines = 0
        dockQtyLabel.font = UIFont.systemFont(ofSize: 15)
        
        addressLabel.text = "0"
        addressLabel.textColor = Colors.darkGray
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 1
        addressLabel.font = UIFont.systemFont(ofSize: 15)
        addressLabel.adjustsFontSizeToFitWidth = false
    }
    
    func configureImageView () {
        bikeImageView.image = Images.bikeWithCycle
        bikeImageView.tintColor = Colors.systemYellow
        bikeImageView.contentMode = .scaleAspectFit
        
        dockImageView.image = Images.parkingsignWithCycle
        dockImageView.tintColor = Colors.systemYellow
        dockImageView.contentMode = .scaleAspectFit
    }
    
    static func nib () -> UINib {
        return UINib(nibName: "FavoriteListTableViewCell", bundle: nil)
    }
    
}
