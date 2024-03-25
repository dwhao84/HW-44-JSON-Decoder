//
//  CustomAnnotation.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/24.
//

import MapKit

class YoubikeAnnotation: NSObject, MKAnnotation {
    
    var image: UIImage?
    
    let title: String?                      // Set up title as string
    let subtitle: String?                   // Set up subtitle as string
    let coordinate: CLLocationCoordinate2D  // Set up coordinate as CLLocationCoordinate2D
    let stationData: Youbike                // Set up stationData as type Youbike.
    var distance: CLLocationDistance?       // Set up distance as CLLocationDistance.

    init(stationData: Youbike) {
        let revisedTitle = stationData.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        self.title = revisedTitle
        self.subtitle = "Available bikes: \(stationData.sbi)"
        self.coordinate = CLLocationCoordinate2D(latitude: stationData.lat, longitude: stationData.lng)
        self.stationData = stationData
        super.init()
    }
}
