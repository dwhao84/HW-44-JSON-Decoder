//
//  YouBikeInfoTableViewCell.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/16.
//

import UIKit

class YouBikeInfoTableViewCell: UITableViewCell {
    
    static let identifier = "YouBikeInfoTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "YouBikeInfoTableViewCell", bundle: nil)
    }
}
