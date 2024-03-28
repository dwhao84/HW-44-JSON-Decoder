//
//  UIView+Ext.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/26.
//

import UIKit

extension UIView {
    func dropShadow () {
        self.frame               = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.layer.shadowColor   = Colors.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset  = CGSize.zero
        self.layer.shadowRadius  = 5
    }
}
