//
//  FunctionsTableViewCell.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/5.
//

import UIKit

class FunctionsTableViewCell: UITableViewCell {
    
    static let identifier: String = "FunctionsTableViewCell"

    let functionLabels: UILabel = UILabel()
    let functionImages: UIImageView = UIImageView()
    
    let functionStackView: UIStackView = UIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureFunctionLabels()
        configureFunctionImages()
        configureFunctionStackView()
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
    
    func configureFunctionLabels () {
        functionLabels.text = "Services"
        functionLabels.textColor = Colors.darkGray
        functionLabels.adjustsFontSizeToFitWidth = true
        functionLabels.textAlignment = .center
        functionLabels.font = UIFont.systemFont(ofSize: 20)
    }
    
    func configureFunctionImages () {
        functionImages.image = Images.bike
        functionImages.tintColor = Colors.darkGray
        functionImages.contentMode = .scaleAspectFill
    }
    
    func configureFunctionStackView () {
        functionStackView.axis = .horizontal
        functionStackView.distribution = .fill
        functionStackView.spacing = 10
        functionStackView.alignment = .center
        functionStackView.addArrangedSubview(functionImages)
        functionStackView.addArrangedSubview(functionLabels)
    }
    
    func constraintFunctionLabel () {
        self.addSubview(functionStackView)
        functionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            functionStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            functionStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

#Preview(traits: .fixedLayout(width: 100, height: 20), body: {
    let cell = FunctionsTableViewCell()
    return cell
})
