//
//  Model.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import Foundation

struct Youbike: Codable {
    // YouBike station
    let sna:     String     // YouBike中文站名
    let snaen:   String     // YouBike英文站名
    // YouBike station status
    let tot:     Int        // 場站總車格
    let sbi:     Int        // 場站目前車輛數
    let bemp:    Int        // 目前空位數量
    // Latitude & Longitude
    let lat:     Double      // 經度
    let lng:     Double      // 緯度
    // Mandarin Station Address
    let sarea:   String     // 市區名
    let ar:      String     // 路名
    // English Station Address
    let sareaen: String     // 英文市區民
    let aren :   String     // 英文路名
}

struct District {
    let district: String
}

let districtListOfTaipei = [
    District(district: "北投區"),
    District(district: "大安區"),
    District(district: "大同區"),
    District(district: "南港區"),
    District(district: "內湖區"),
    District(district: "士林區"),
    District(district: "松山區"),
    District(district: "萬華區"),
    District(district: "文山區"),
    District(district: "信義區"),
    District(district: "中山區"),
    District(district: "中正區")
]

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
 
