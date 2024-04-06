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

    @NSManaged public var stationName: String?
    @NSManaged public var distance: String?
    @NSManaged public var detailStationName: String?
    @NSManaged public var dockQty: String?
    @NSManaged public var bikeQty: String?

}

extension FavoriteListData : Identifiable {

}
