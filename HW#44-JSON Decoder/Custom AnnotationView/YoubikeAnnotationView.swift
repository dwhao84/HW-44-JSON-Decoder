//
//  CustomAnnotationView.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/26.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    static let customAnnotationView: String = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        canShowCallout = true
        update(for: annotation)
    }
    
    override var annotation: MKAnnotation? { didSet { update(for: annotation) } }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(for annotation: MKAnnotation?) {
        image = (annotation as? YoubikeAnnotation)?.image
    }
}
