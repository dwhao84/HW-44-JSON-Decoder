//
//  FunctionModel.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/6.
//

import UIKit

struct Services {
    let serviceImage: UIImage
    let serviceTitle: String
}

let servicesArray: [Services] = [
    Services(serviceImage: Images.bike, serviceTitle: "Station Map"),
    Services(serviceImage: Images.locationFill, serviceTitle: "Change Location"),
    Services(serviceImage: Images.message, serviceTitle: "News Updates"),
    Services(serviceImage: Images.network, serviceTitle: "Activity"),
    Services(serviceImage: Images.house, serviceTitle: "Service Center"),
    Services(serviceImage: Images.doc, serviceTitle: "Rental Instructions"),
    Services(serviceImage: Images.badget, serviceTitle: "Get Insured"),
    Services(serviceImage: Images.lostAndFound, serviceTitle: "Lost & Found"),
    Services(serviceImage: Images.radioWavesSec, serviceTitle: "Report Lost YouBike"),
]
