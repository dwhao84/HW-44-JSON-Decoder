//
//  CustomAnnotation.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/24.
//

import MapKit

class YoubikeAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let stationData: Youbike

    init(stationData: Youbike) {
        
        let revisedTitle = stationData.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        
        self.title = revisedTitle
        self.subtitle = "Available bikes: \(stationData.sbi)"
        self.coordinate = CLLocationCoordinate2D(latitude: stationData.lat, longitude: stationData.lng)
        self.stationData = stationData
        super.init()
    }
}
