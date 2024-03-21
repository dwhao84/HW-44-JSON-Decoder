//
//  MapViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/16.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let searchView: SearchView           = SearchView()
    let informationView: InformationView = InformationView()

    var mapView: MKMapView           = MKMapView ()
    let navigateBtn: UIButton        = UIButton(type: .system)
    
    let locations = [""]
    let locationManager = CLLocationManager()
    
    var currentCoordinates: CLLocationCoordinate2D?
    
    var selectedStation: Youbike?
    var stationNames = [Youbike]()
    
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setMapView       ()
        setNavigateButton()
        updateMapView    ()
    }
    
    func updateMapView () {
        if let station = selectedStation {
            let coordinate = CLLocationCoordinate2D(latitude: station.lat, longitude: station.lng)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            var selectedStationName = station.sna
            selectedStationName = station.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
            
            annotation.title      =  selectedStationName
            mapView.addAnnotation(annotation)
            mapView.centerCoordinate = coordinate
        }
    }

    
// MARK: - Set up navigationButton
    func setNavigateButton () {
        setupNavigationBtn       ()
        addShadowForNavigationBtn ()
        constraintsInformationView()
        constriantNavigateBtn    ()
    }
    
    func setupNavigationBtn () {
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = Colors.systemYellow
        config.baseForegroundColor         = Colors.white
        config.image                       = Images.locationFill
        config.background.imageContentMode = .scaleToFill
        config.buttonSize                  = UIButton.Configuration.Size.medium
        config.background.cornerRadius     = NavigationButtonSize.height / 2
//        config.background.strokeColor      = Colors.systemGray3
        navigateBtn.configuration = config
        navigateBtn.addTarget(self, action: #selector(navigationBtnTapped), for: .touchUpInside)
    }
    
    func addShadowForNavigationBtn  () {
        navigateBtn.layer.shadowColor   = Colors.darkGray.cgColor
        navigateBtn.layer.shadowOffset  = CGSize(width: 0.0, height: 1)
        navigateBtn.layer.shadowRadius  = 20
        navigateBtn.layer.shadowOpacity = 0.5
        navigateBtn.layer.masksToBounds = false
    }
    
    func constriantNavigateBtn () {
        view.addSubview(navigateBtn)
        navigateBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigateBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            navigateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            navigateBtn.widthAnchor.constraint(equalToConstant: NavigationButtonSize.width),
            navigateBtn.heightAnchor.constraint(equalToConstant: NavigationButtonSize.height),
        ])
    }
    
    @objc func navigationBtnTapped (_ sender: UIButton) {
        print("navigationBtnTapped")
        setupLocationManager()
    }
    
    
    
// MARK: - Set up mapView:
    func setMapView () {
        delegateAndDataSource()
        constraintMapView    ()
        setupMapView         ()
    }
    
    func setupLocationManager () {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    func setupMapView () {
        mapView.mapType           = .standard
        mapView.isZoomEnabled     = true
        mapView.isScrollEnabled   = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.0474, longitude: 121.5171), latitudinalMeters: 250, longitudinalMeters: 250)
    }
    
    func delegateAndDataSource () {
        mapView.delegate         = self
        locationManager.delegate = self
    }

    func constraintMapView () {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo:  view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func constraintsInformationView () {
        view.addSubview(informationView)
        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            informationView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinates = locations.first?.coordinate
        print(currentCoordinates!)
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(currentCoordinates!.latitude, currentCoordinates!.longitude), latitudinalMeters: 250, longitudinalMeters: 250), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


#Preview {
    UINavigationController(rootViewController: MapViewController())
}
