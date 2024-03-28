//
//  MapPinView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/27.
//

import UIKit
import MapKit

class MapPinView: MKAnnotationView {
    
    let width: CGFloat = 40.0
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        view.backgroundColor    = Colors.white
        view.layer.cornerRadius = width / 2
        view.layer.borderWidth  = 2.5
        view.layer.borderColor  = Colors.green.cgColor
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image              = Images.radioWave
        imageview.tintColor          = Colors.green
        imageview.contentMode        = .scaleAspectFill
        imageview.layer.cornerRadius = 8.0
        imageview.clipsToBounds      = true
        return imageview
    }()
    
    // MARK: Initialization
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0).isActive = true
    }
}
