//
//  FavoriteButton.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/7.
//

import UIKit

class FavoriteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ?  0.3 : 1
        }
    }
}
