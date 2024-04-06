//
//  FunctionModel.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/6.
//

import UIKit

struct Functions {
    let serviceImage: UIImage
    let serviceTitle: String
}

let servicesArray: [Functions] = [
    Functions(serviceImage: Images.bike, serviceTitle: "Station Map"),
    Functions(serviceImage: Images.locationFill, serviceTitle: "Change Location"),
    Functions(serviceImage: Images.message, serviceTitle: "News Updates"),
    Functions(serviceImage: Images.network, serviceTitle: "Activity"),
    Functions(serviceImage: Images.house, serviceTitle: "Service Center"),
    Functions(serviceImage: Images.doc, serviceTitle: "Rental Instructions"),
    Functions(serviceImage: Images.badget, serviceTitle: "Get Insured"),
    Functions(serviceImage: Images.lostAndFound, serviceTitle: "Lost & Found"),
    Functions(serviceImage: Images.radioWavesSec, serviceTitle: "Report Lost YouBike"),
]
