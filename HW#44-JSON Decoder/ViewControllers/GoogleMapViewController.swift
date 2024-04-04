//
//  GoogleMapViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/4/3.
//

import UIKit
import GoogleMaps
import GoogleNavigation


class GoogleMapViewController: UIViewController {
    
    var mapView: GMSMapView                = GMSMapView()
    var locationManager: CLLocationManager = CLLocationManager()
    
    var lat: CLLocationDegrees = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        constraintsmapView ()
        

    }
    
    func configureMapView () {
        let camera = GMSCameraPosition.camera(
            withLatitude: 23.6,
            longitude: 120.9,
            zoom: 15
          )
        mapView.delegate = self
        mapView.camera = camera
        mapView.mapType = .normal
        mapView.cameraMode = .overview

    }
    
    func constraintsmapView () {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
}

extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("didTapAt")
    }
}

#Preview {
    UINavigationController(rootViewController: GoogleMapViewController())
}
