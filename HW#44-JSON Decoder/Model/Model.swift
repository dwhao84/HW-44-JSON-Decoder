//
//  Model.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/15.
//

import Foundation

struct Youbike: Codable {
    let sna:   String     // YouBike中文站名
    let snaen: String     // YouBike英文站名
    
    let tot:  Int         // 場站總車格
    let sbi:  Int         // 場站目前車輛數
    let bemp: Int         // 目前空位數量
    
    let lat: Double       // 經度
    let lng: Double       // 緯度
    
    let sarea: String     // 市區名
    let ar:    String     // 路名
    
    let sareaen: String   // 英文市區民
    let aren :   String   // 英文路名
}

func fetchData () {
    if let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") { URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let stationName = try JSONDecoder().decode(Youbike.self, from: data)
                print(stationName)
            } catch {
                print(error)
            }
        }
    }
  }
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
 
