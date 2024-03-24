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
    
    let informationView: InformationView = InformationView()
    
    var mapView: MKMapView           = MKMapView ()
    let navigateBtn: UIButton        = UIButton(type: .system)
    
    let locations = [""]
    let locationManager = CLLocationManager()
    var currentCoordinates: CLLocationCoordinate2D?
    
    var selectedStation: Youbike?
    var coordinates = [Youbike]()
    
    let searchView: UIView = UIView()
    let searchTextField: UITextField = UITextField()
    let searchStackView: UIStackView = UIStackView()
    
    var listBtn: UIButton = {
        let listBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.lightGray
        config.imagePlacement = .all
        config.image = Images.listBullet
        config.automaticallyUpdateForSelection = true
        listBtn.configuration = config
        return listBtn
    } ()
    
    var favoriteBtn: UIButton = {
        let favoriteBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.lightGray
        config.imagePlacement = .all
        config.image = Images.starFill
        config.automaticallyUpdateForSelection = true
        favoriteBtn.configuration = config
        return favoriteBtn
    } ()
    
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchYoubikeData()
        
        favoriteBtn.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)
        listBtn.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
    }
    
    func fetchYoubikeData() {
        if let urlString = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let youbikeData = try decoder.decode([Youbike].self, from: data)
                        
                        // Prepare to update the mapView with new annotations
                        var annotations = [YoubikeAnnotation]() // Use your custom annotation class
                        for station in youbikeData {
                            // Create an instance of YoubikeAnnotation for each station
                            let annotation = YoubikeAnnotation(stationData: station)
                            annotations.append(annotation)
                        }
                        
                        DispatchQueue.main.async {
                            // Remove existing annotations to avoid duplicates
                            self.mapView.removeAnnotations(self.mapView.annotations)
                            // Add the new set of annotations
                            self.mapView.addAnnotations(annotations)
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    
    
    // MARK: - Set up UI:
    func setupUI () {
        setMapView       ()
        configureTextField()
        searchTextField.delegate = self
        setNavigateButton ()
        configureSearchStackView()
        constraintsSearchStackView()
    }
    
    // MARK: - Set up UITextField
    func configureTextField () {
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds      = true
        searchTextField.borderStyle        = .none
        searchTextField.backgroundColor    = Colors.white
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search Stations",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.lightGray]
        )
        searchTextField.font               = UIFont.systemFont(ofSize: 15)
        searchTextField.textColor          = Colors.darkGray
        searchTextField.isUserInteractionEnabled = true
    }
    
    func configureSearchStackView () {
        searchTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchStackView.axis = .horizontal
        searchStackView.distribution = .fill
        searchStackView.spacing = 20
        searchStackView.addArrangedSubview(listBtn)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(favoriteBtn)
    }
    
    // MARK: - Set up navigationBtn
    func setNavigateButton () {
        setupNavigationBtn       ()
        addShadowForNavigationBtn ()
        constraintsInformationView()
        constriantsNavigateBtn()
    }
    
    func setupNavigationBtn () {
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = Colors.systemYellow
        config.baseForegroundColor         = Colors.white
        config.image                       = Images.locationFill
        config.background.imageContentMode = .scaleToFill
        config.buttonSize                  = UIButton.Configuration.Size.medium
        config.background.cornerRadius     = NavigationButtonSize.height / 2
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
    
    func constriantsNavigateBtn () {
        view.addSubview(navigateBtn)
        navigateBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigateBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            navigateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            navigateBtn.widthAnchor.constraint(equalToConstant: NavigationButtonSize.width),
            navigateBtn.heightAnchor.constraint(equalToConstant: NavigationButtonSize.height),
        ])
    }
    
    // MARK: - Actions:
    @objc func navigationBtnTapped (_ sender: UIButton) {
        print("navigationBtnTapped")
        setupLocationManager()
    }
    
    @objc func favoriteBtnTapped (_ sender: UIButton) {
        print("favoriteBtnTapped")
    }
    
    @objc func listBtnTapped (_ sender: UIButton) {
        print("listBtnTapped")
    }
    
    // MARK: - Set up mapView:
    func setMapView () {
        delegateAndDataSource()
        constraintMapView    ()
        setupMapView         ()
        setupLocationManager ()
    }
    
    // 設定Location Manager
    func setupLocationManager () {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.showsUserLocation = true
        //        locationManager.startUpdatingLocation()
    }
    
    // 設定MapView的細節
    func setupMapView () {
        mapView.mapType           = .standard
        mapView.isZoomEnabled     = true
        mapView.isScrollEnabled   = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 25.0474,
                longitude: 121.5171
            ),
            latitudinalMeters: 250,
            longitudinalMeters: 250
        )
    }
    
    // Add Delegate & Data source
    func delegateAndDataSource () {
        mapView.delegate         = self
        locationManager.delegate = self
    }
    
    func checkLocationAuthorization () {
        guard locationManager == locationManager,
              let location = locationManager.location else { return }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
        case .denied:
            print("Location services has been denied")
        case .notDetermined, .restricted:
            print("Location cannot be determined or restricted.")
        @unknown default:
            print("Unknown error. Unable to get location.")
        }
    }
    
    private func findNearByPlaces(by query: String) {
        mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, error == nil else { return }
            print(response.mapItems)
        }
    }
    
    // MARK: - Constraints View:
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
    
    // MARK: - Constraints InformationView
    func constraintsInformationView () {
        view.addSubview(informationView)
        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            informationView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    // MARK: - Constraints SearchStackView
    func constraintsSearchStackView () {
        searchStackView.backgroundColor = Colors.white
        searchStackView.layer.cornerRadius = 10
        view.addSubview(searchStackView)
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
    }
    
}

// MARK: - MKMapViewDelegate:
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let youbikeAnnotation = view.annotation as? YoubikeAnnotation else { return }
        
        let stationLocation = CLLocation(latitude: youbikeAnnotation.coordinate.latitude, longitude: youbikeAnnotation.coordinate.longitude)
        let distance = currentCoordinates
        
        let title = youbikeAnnotation.stationData.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        // Update your custom view with the data from the selected annotation
        informationView.stationNameLabel.text = title
        informationView.bikeQtyLabel.text     = "\(youbikeAnnotation.stationData.sbi)"
        informationView.dockQtyLabel.text     = "\(youbikeAnnotation.stationData.bemp)"
        informationView.addressLabel.text     = youbikeAnnotation.stationData.ar
        informationView.updateTimeLabel.text  = youbikeAnnotation.stationData.updateTime
        informationView.distanceLabel.text    = youbikeAnnotation.stationData.updateTime
        
    }
}


// MARK: - CLLocationManagerDelegate:
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentCoordinates = locations.first?.coordinate
        print("DEBUG PRINT: 我目前的座標位置:\(currentCoordinates!)")
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(currentCoordinates!.latitude, currentCoordinates!.longitude), latitudinalMeters: 250, longitudinalMeters: 250), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

// MARK: - UITextFieldDelegate:
extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Start editing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("textFieldShouldReturn")
        return true
    }
}

#Preview {
    UINavigationController(rootViewController: MapViewController())
}
