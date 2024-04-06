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
    
    // CustomView
    let informationView: InformationView = InformationView()
    
    var mapView: MKMapView           = MKMapView ()
    let navigateBtn: UIButton        = UIButton(type: .system)
    
    let locationManager = CLLocationManager()        // Create the location manager.
    var currentCoordinates: CLLocationCoordinate2D?  // Get the current coordinate.
    var currentUserLocation: CLLocation?             // Get the current location.
    
    var selectedStation: Youbike?
    var coordinates = [Youbike]()
    
    var allStationNames = [Youbike]()
    var filterStations  = [Youbike]()
    
    let searchView: UIView = UIView()
    let searchTextField: UITextField = UITextField()
    let searchStackView: UIStackView = UIStackView()
    
    var slideInTransitioningDelegate: UIViewControllerTransitioningDelegate? 
    
    var navigateBtnBottomConstraint: NSLayoutConstraint!
    
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
        fetchYoubikeData() // Fetch Youbike data.
        addTargets()       // Add targets include btns, textFields.
        tapTheView ()      // Tap the view.
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    // MARK: - Add Tap Gesture
    func tapTheView () {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTheView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Add Targets
    func addTargets () {
        favoriteBtn.addTarget(self, action: #selector(favoriteBtnTapped), for: .touchUpInside)
        listBtn.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(searchHandle), for: .editingChanged)
    }
    
    // MARK: - fetchYoubikeData
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
                        // Update UI by using DispatchQueue.main.async
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
        constraintsSearchView()
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
    
    // MARK: SearchStackView
    func configureSearchStackView () {
        searchTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        favoriteBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteBtn.heightAnchor.constraint(equalTo: favoriteBtn.widthAnchor, multiplier: 1).isActive = true
        listBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        listBtn.heightAnchor.constraint(equalTo: listBtn.widthAnchor, multiplier: 1).isActive = true
        
        searchStackView.axis = .horizontal
        searchStackView.distribution = .equalSpacing
        searchStackView.alignment    = .center
        searchStackView.spacing = 8
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
        navigateBtn.configuration          = config
        navigateBtn.addTarget(self, action: #selector(navigateBtnTapped), for: .touchUpInside)
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
        navigateBtnBottomConstraint = navigateBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
        NSLayoutConstraint.activate([
            navigateBtnBottomConstraint,
            navigateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            navigateBtn.widthAnchor.constraint(equalToConstant: NavigationButtonSize.width),
            navigateBtn.heightAnchor.constraint(equalToConstant: NavigationButtonSize.height)
        ])
    }
    
    // MARK: - Tap Gesture actions:
    @objc func tappedTheView (_ sender: UITapGestureRecognizer) {
        informationView.isHidden = true
        searchStackView.isHidden = true
        navigateBtn.isHidden     = false
        moveButton()
    }
    
    func moveButton() {
        // Back to -35
        navigateBtnBottomConstraint.constant = -35
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }

    
    // MARK: - Button actions:
    @objc func navigateBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: navigationBtn Tapped, and navigate the current location.")
        setupLocationManager()
    }
    
    @objc func favoriteBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: favoriteBtnTapped")
    }
    
    @objc func listBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: listBtnTapped")
        
        let sideVC = SideViewController()
        sideVC.modalPresentationStyle = .overFullScreen
        slideInTransitioningDelegate = SlideInTransitioningDelegate()
        sideVC.transitioningDelegate = slideInTransitioningDelegate
        present(sideVC, animated: true, completion: nil)
    }
    
    @objc func searchHandle (_ sender: UITextField) {
        print("DEBUG PRINT: searchHandle")
        guard let searchText = sender.text?.lowercased(), !searchText.isEmpty else {
            filterStations = allStationNames
            return
        }
        filterStations = allStationNames.filter {
            $0.sna.lowercased().contains(searchText)
        }
    }
    
    // MARK: - Set up mapView:
    func setMapView () {
        setupMapView         ()
        setupLocationManager ()
        constraintMapView    ()
    }
    
    // 設定Location Manager
    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.showsUserLocation = true
    }
    
    // 設定MapView的細節
    func setupMapView () {
        mapView.delegate         = self
        mapView.mapType           = .standard
        mapView.isZoomEnabled     = true
        mapView.isScrollEnabled   = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(
                latitude: 25.0474,
                longitude: 121.5171
            ),
            latitudinalMeters: 250,
            longitudinalMeters: 250
        )
    }
    
    
    func checkLocationAuthorization () {
        guard locationManager == locationManager,
              let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
            
        case .authorizedAlways, .authorizedWhenInUse:
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
        case .denied:
            print("DEBUG PRINT: Location services has been denied")
        case .notDetermined, .restricted:
            print("DEBUG PRINT: Location cannot be determined or restricted.")
        @unknown default:
            print("DEBUG PRINT: Unknown error. Unable to get location.")
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
    func constraintsSearchView () {
        searchTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        searchStackView.backgroundColor = Colors.white
        searchStackView.layer.cornerRadius = 10
        searchStackView.dropShadow()
        
        view.addSubview(searchStackView)
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),            searchStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchStackView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("DEBUG PRINT:  locationManager DidChangeAuthorization")
    }
    
}

// MARK: - MKMapViewDelegate:
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let youbikeAnnotation = view.annotation as? YoubikeAnnotation else { return }
        
        // Station's location.
        let stationLocation = CLLocation(latitude: youbikeAnnotation.coordinate.latitude, longitude: youbikeAnnotation.coordinate.longitude)
        
        // 假设你有一个名为 currentUserLocation 的 CLLocation 实例，存储了用户的当前位置
        if let currentUserLocation = self.currentUserLocation {
            let distance = currentUserLocation.distance(from: stationLocation)
            print("目前距離：\(distance) 公尺")
            
            informationView.distanceLabel.text = "距離\(Int(distance))公尺"
        }
        
        let title: String = youbikeAnnotation.stationData.sna.replacingOccurrences(of: "YouBike2.0_", with: "")
        
        let bikeQtyLabel: String    = "\(youbikeAnnotation.stationData.sbi)"
        let dockQtyLabel: String    = "\(youbikeAnnotation.stationData.bemp)"
        let addressLabel: String    = youbikeAnnotation.stationData.ar
        let updateTimeLabel: String = youbikeAnnotation.stationData.updateTime
        
        // Update your custom view with the data from the selected annotation
        informationView.stationNameLabel.text = title
        informationView.bikeQtyLabel.text     = bikeQtyLabel
        informationView.dockQtyLabel.text     = dockQtyLabel
        informationView.addressLabel.text     = addressLabel
        informationView.updateTimeLabel.text  = updateTimeLabel
        
        informationView.isHidden = false
        navigateBtn.isHidden     = false
        searchStackView.isHidden = false
        
        // Update the navigationBtn from previous setting.
        navigateBtnBottomConstraint.constant = -120
    }
    
}


// MARK: - CLLocationManagerDelegate:
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentUserLocation = locations.last              // Get the latest coordinate from location.
        currentCoordinates  = locations.first?.coordinate // Get the latest coordinate in locations of array.
        
        // Set the current coordinates into the mapView
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2DMake(currentCoordinates!.latitude, currentCoordinates!.longitude), latitudinalMeters: 250, longitudinalMeters: 250), animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - UITextFieldDelegate:
extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("DEBUG PRINT: Start editing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("DEBUG PRINT: textFieldShouldReturn")
        return true
    }
}

#Preview {
    UINavigationController(rootViewController: MapViewController())
}

class SlideInTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator(isPresenting: false)
    }
}

class SlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3 // Duration of the animation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        
        let container = transitionContext.containerView
        
        if isPresenting {
            container.addSubview(controller.view)
            controller.view.frame = CGRect(x: -container.frame.width, y: 0, width: container.frame.width, height: container.frame.height)
        }
        
        let transform = {
            controller.view.transform = self.isPresenting ? CGAffineTransform(translationX: container.frame.width, y: 0) : CGAffineTransform(translationX: -container.frame.width, y: 0)
        }
        
        let completion = { (_: Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: transform, completion: completion)
    }
}
