//
//  FunctionsTableViewCell.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit

class FunctionsTableViewCell: UITableViewCell {
    
    static let identifier: String = "FunctionsTableViewCell"

    let functionsTitle: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureFunctionLabel()
        constraintFunctionLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepareForReuse")
    }
    
    func configureFunctionLabel () {
        functionsTitle.text = "XXX"
        functionsTitle.textColor = Colors.darkGray
        functionsTitle.adjustsFontSizeToFitWidth = true
        functionsTitle.textAlignment = .center
        functionsTitle.font = UIFont.systemFont(ofSize: 20)
    }
    
    func constraintFunctionLabel () {
        self.addSubview(functionsTitle)
        functionsTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            functionsTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            functionsTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 20), body: {
    let cell = FunctionsTableViewCell()
    return cell
})
