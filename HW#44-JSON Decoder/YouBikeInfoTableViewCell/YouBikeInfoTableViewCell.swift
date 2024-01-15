//
//  YouBikeInfoTableViewCell.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/16.
//

import UIKit

class YouBikeInfoTableViewCell: UITableViewCell {
    
    static let identifier = "YouBikeInfoTableViewCell"
    
    @IBOutlet weak var youBikeStationName: UILabel!
    @IBOutlet weak var youBikeStationNameEN: UILabel!
    
    @IBOutlet weak var bikeQtyTitleLabel: UILabel!
    @IBOutlet weak var leftoverBikeQtyTitleLabel: UILabel!
    
    @IBOutlet weak var bikeQtyLabel: UILabel!
    @IBOutlet weak var leftoverBikeQtyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        youBikeStationName.text   = "YouBike中文站名"
        youBikeStationNameEN.text = "YouBike英文站名"
        
        bikeQtyTitleLabel.text = "目前車輛數:"
        leftoverBikeQtyTitleLabel.text = "剩餘車位:"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "YouBikeInfoTableViewCell", bundle: nil)
    }
}
