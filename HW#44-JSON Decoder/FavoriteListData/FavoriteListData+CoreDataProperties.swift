//
//  FavoriteListData+CoreDataProperties.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/7.
//
//

import Foundation
import CoreData


extension FavoriteListData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteListData> {
        return NSFetchRequest<FavoriteListData>(entityName: "FavoriteListData")
    }

    @NSManaged public var stationName: String?       // 站名
    @NSManaged public var address: String?           // 細節站名
    @NSManaged public var dockQty: String?           // 站台數量
    @NSManaged public var bikeQty: String?           // 車台數量

}

extension FavoriteListData : Identifiable {

}
