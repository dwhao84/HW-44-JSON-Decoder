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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureLabel()
        configureImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        bikeQtyLabel.font = UIFont.systemFont(ofSize: 17)
        
        dockQtyLabel.text = "0"
        dockQtyLabel.textColor = Colors.darkGray
        dockQtyLabel.textAlignment = .center
        dockQtyLabel.numberOfLines = 0
        dockQtyLabel.font = UIFont.systemFont(ofSize: 17)
        
        addressLabel.text = "0"
        addressLabel.textColor = Colors.darkGray
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 0
        addressLabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureImageView () {
        bikeImageView.image = Images.bikeWithCycle
        bikeImageView.tintColor = Colors.systemYellow
        bikeImageView.contentMode = .scaleAspectFill
        
        dockImageView.image = Images.parkingsignWithCycle
        dockImageView.tintColor = Colors.systemYellow
        dockImageView.contentMode = .scaleAspectFill
    }
    
}
