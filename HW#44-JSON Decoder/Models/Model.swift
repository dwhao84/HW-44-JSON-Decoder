//
//  Model.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import UIKit
import MapKit

struct Youbike: Codable {
    // YouBike station details
    var sna: String     // YouBike中文站名
    var snaen: String   // YouBike英文站名
    var tot: Int        // 場站總車格
    var sbi: Int        // 場站目前車輛數
    var bemp: Int       // 目前空位數量
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
}




// " sno":"500101004",
// " sna":"YouBike2.0_和平公園東側",
// " tot":11,
// " sbi":11,
// " sarea":"大安區",
// " mday":"2024-01-14 22:54:05",
// " lat":25.02351,
// " lng":121.54282,
// " ar":"和平東路二段118巷33號",
// " sareaen":"Daan Dist.",
// " snaen":"YouBike2.0_Heping Park (East)",
// " aren":"No. 33， Ln. 118， Sec. 2， Heping E. Rd",
// " bemp":0,
// " act":"1",ㄋ
// " srcUpdateTime":"2024-01-14 22:54:23",
// " updateTime":"2024-01-14 22:54:35",
// " infoTime":"2024-01-14 22:54:05",
// " infoDate":"2024-01-14"

