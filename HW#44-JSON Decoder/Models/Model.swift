//
//  Model.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import UIKit
import MapKit
import CoreLocation

struct Youbike: Codable {
    var sna: String     // YouBike中文站名
    var snaen: String   // YouBike英文站名
    var tot: Int        // 場站總車格
    var sbi: Int       // 場站目前車輛數，現在作為可選字段
    var bemp: Int      // 目前空位數量，現在作為可選字段
    var lat: Double     // 緯度
    var lng: Double     // 經度
    var sarea: String   // 市區名
    var ar: String      // 路名
    var sareaen: String // 英文市區名
    var aren: String    // 英文路名
    var srcUpdateTime: String
    var updateTime: String
    
    // MKAnnotation requires a 'coordinate' property
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: lat, longitude: lng) }

    enum CodingKeys: String, CodingKey {
        case sna, snaen, sarea, ar, sareaen, aren, srcUpdateTime, updateTime
        case tot = "total"
        case sbi = "available_rent_bikes"
        case bemp = "available_return_bikes"
        case lat = "latitude"
        case lng = "longitude"
    }
    
    // 使用 `decodeIfPresent` 方法來解碼可選字段
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sna = try container.decode(String.self, forKey: .sna)
        snaen = try container.decode(String.self, forKey: .snaen)
        tot = try container.decode(Int.self, forKey: .tot)
        sbi = try container.decodeIfPresent(Int.self, forKey: .sbi) ?? 0
        bemp = try container.decodeIfPresent(Int.self, forKey: .bemp) ?? 0
        lat = try container.decode(Double.self, forKey: .lat)
        lng = try container.decode(Double.self, forKey: .lng)
        sarea = try container.decode(String.self, forKey: .sarea)
        ar = try container.decode(String.self, forKey: .ar)
        sareaen = try container.decode(String.self, forKey: .sareaen)
        aren = try container.decode(String.self, forKey: .aren)
        srcUpdateTime = try container.decode(String.self, forKey: .srcUpdateTime)
        updateTime = try container.decode(String.self, forKey: .updateTime)
    }
}
