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

    var mapView = MKMapView ()
    let navigateBtn: UIButton        = UIButton()
    let customerServiceBtn: UIButton = UIButton()
    
    let locations = [""]
    let locationManager = CLLocationManager()
    
    var locValue: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView       ()
        setNavigateButton()
//        setCustomerServiceButton ()
    }
 // MARK: - Set up customerServiceButton
    func setCustomerServiceButton () {
        setupCustomerServiceBtnUI       ()
        addShadowForCustomerServiceBtn  ()
        constriantCustomerServiceBtn    ()
    }
        
    func setupCustomerServiceBtnUI () {
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = UIColorSelection.white
        config.image = UIImage(systemName: "info.circle.fill")
        config.background.imageContentMode = .scaleToFill
        config.buttonSize                  = UIButton.Configuration.Size.large
        config.background.cornerRadius     = 35
        config.background.backgroundColor  = UIColorSelection.white
        config.background.strokeColor      = UIColorSelection.lightGray
        customerServiceBtn.configuration = config
        
        customerServiceBtn.addTarget(self, action: #selector(CustomerServiceBtnTapped), for: .touchUpInside)
    }
    
    func addShadowForCustomerServiceBtn () {
        customerServiceBtn.layer.shadowColor   = UIColorSelection.darkGray.cgColor
        customerServiceBtn.layer.shadowOffset  = CGSize(width: 0.0, height: 0.6)
        customerServiceBtn.layer.shadowRadius  = 20
        customerServiceBtn.layer.shadowOpacity = 0.5
        customerServiceBtn.layer.masksToBounds = false
    }
    
    func constriantCustomerServiceBtn () {
        view.addSubview(customerServiceBtn)
        customerServiceBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customerServiceBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            customerServiceBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            customerServiceBtn.widthAnchor.constraint(equalToConstant: 70),
            customerServiceBtn.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    @objc func CustomerServiceBtnTapped () {
        print("CustomerServiceBtnTapped")
    }
    
// MARK: - Set up navigationButton
    func setNavigateButton () {
        setupNavigateButtonUI       ()
        addShadowForNavigationButton()
        constriantNavigateButton    ()
    }
        
    
    func setupNavigateButtonUI () {
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = UIColorSelection.white
        config.image = UIImage(systemName: "location")
        config.background.imageContentMode = .scaleAspectFill
        config.buttonSize                  = UIButton.Configuration.Size.large
        config.background.cornerRadius     = 35
        config.background.backgroundColor  = UIColorSelection.white
        config.background.strokeColor      = UIColorSelection.lightGray
        navigateBtn.configuration = config
        
        navigateBtn.addTarget(self, action: #selector(navigationBtnTapped), for: .touchUpInside)
    }
    
    func addShadowForNavigationButton () {
        navigateBtn.layer.shadowColor   = UIColorSelection.darkGray.cgColor
        navigateBtn.layer.shadowOffset  = CGSize(width: 0.0, height: 0.6)
        navigateBtn.layer.shadowRadius  = 20
        navigateBtn.layer.shadowOpacity = 0.5
        navigateBtn.layer.masksToBounds = false
    }
    
    func constriantNavigateButton () {
        view.addSubview(navigateBtn)
        navigateBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigateBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            navigateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            navigateBtn.widthAnchor.constraint(equalToConstant: 70),
            navigateBtn.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    @objc func navigationBtnTapped () {
        print("navigationBtnTapped")
        setupLocationManager()
        print("\(locValue?.latitude)")
    }
    
    
    
// MARK: - Set up tableView:
    func setMapView () {
        delegateAndDataSource()
        constraintMapView    ()
        setupMapView         ()
    }
    
    func setupLocationManager () {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupMapView () {
        mapView.mapType           = .standard
        mapView.isZoomEnabled     = true
        mapView.isScrollEnabled   = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.0474, longitude: 121.5171), latitudinalMeters: 250, longitudinalMeters: 250)
    }
    
    func delegateAndDataSource () {
        mapView.delegate        = self
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

}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let locationValue = CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        
    }
}


#Preview {
    UINavigationController(rootViewController: MapViewController())
}
