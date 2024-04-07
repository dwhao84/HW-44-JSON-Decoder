//
//  CustomAnnotation.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/3/24.
//
import UIKit
import MapKit

class YoubikeAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?
    var stationData: Youbike

    init(stationData: Youbike) {
        self.title = stationData.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        self.subtitle = "剩餘車輛: \(stationData.sbi) / 剩餘車位: \(stationData.bemp)"
        self.coordinate = CLLocationCoordinate2D(latitude: stationData.lat, longitude: stationData.lng)
        self.stationData = stationData
        super.init()
    }
}
