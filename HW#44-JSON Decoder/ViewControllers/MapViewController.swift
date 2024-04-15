//
//  MapViewController.swift
//  HW#44-JSON Decoder
//
//  Created by Dawei Hao on 2024/1/16.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController, InformationViewDelegate {
    
    // MARK: - Import the InfoView Delegate:
    func routeBtnDidTap() {
        print("DEBUG PRINT: InfoView's RouteBtn")
        
        // 取得目的地的座標
        let targetCoordinate = didSelectedLocation
        // 取得目的地的座標後，將座標改成placeamark的型別.
        let targetPlacemark = MKPlacemark(coordinate: targetCoordinate!)
        
        // 將 placeamark的型別改成 MKMapItem，並命名為targetItem
        let targetItem = MKMapItem(placemark: targetPlacemark)
        targetItem.name = didSelectedStationName
        
        // 取得使用者的座標
        let userMapItem = MKMapItem.forCurrentLocation()
        
        // Build the routes from userMapItem to targetItem
        let routes = [userMapItem, targetItem]
        
        // Default setting for user by using walking to the destination.
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
    }
    
    func favoriteButtonDidTap() {
        guard let selectedAnnotation = selectedPlaces as? YoubikeAnnotation else {
            print("DEBUG PRINT: No selected annotation to save.")
            return
        }

        // 直接保存到 CoreData
        savePlaceToCoreData(annotation: selectedAnnotation)
        print("DEBUG PRINT: Annotation saved.")

        // 打印 selectedAnnotation 的所有详细信息
        if let title = selectedAnnotation.title, let subtitle = selectedAnnotation.subtitle {
            print("""
                  DEBUG PRINT: Title: \(title), Subtitle: \(subtitle)
                  DEBUG PRINT: Coordinate: \(selectedAnnotation.coordinate.latitude), \(selectedAnnotation.coordinate.longitude)
                  """)
        } else {
            print("DEBUG PRINT: Annotation lacks title or subtitle")
        }

        favoriteButtonCount += 1
        print("favoriteBtnCount: \(favoriteButtonCount)")
    }


    
    
    // MARK: - Declare the instance & variable
    let informationView: InformationView = InformationView()
    
    var mapView: MKMapView = MKMapView ()
    var scaleView: MKScaleView = MKScaleView()
    
    // Create the location manager.
    let locationManager = CLLocationManager()
    
    // Get the current coordinate.
    var currentCoordinates: CLLocationCoordinate2D?
    
    // Get the current location.
    var currentUserLocation: CLLocation?
    
    // Stored the selected location.
    var didSelectedLocation: CLLocationCoordinate2D?
    var didSelectedStationName: String?
    
    var selectedStation: Youbike?
    var coordinates = [Youbike]()
    
    var allStationNames = [Youbike]()
    var filterStations  = [Youbike]()
    
    let searchView: UIView = UIView()
    let searchTextField: UITextField = UITextField()
    let searchStackView: UIStackView = UIStackView()
    
    var slideInTransitioningDelegate: UIViewControllerTransitioningDelegate?
    var navigateBtnBottomConstraint: NSLayoutConstraint!
    
    // Use it for the btn count to observe changes of btn.
    var favoriteButtonCount: Int = 0
    // Create a variable for selected places.
    var selectedPlaces: MKAnnotation?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Custom UI.
    var navigateBtn: UIButton = {
        let navigateBtn: UIButton = UIButton(type: .system)
        var config                         = UIButton.Configuration.plain()
        config.background.backgroundColor  = Colors.systemYellow
        config.baseForegroundColor         = Colors.white
        config.image                       = Images.locationFill
        config.background.imageContentMode = .scaleToFill
        config.buttonSize                  = UIButton.Configuration.Size.medium
        config.background.cornerRadius     = NavigationButtonSize.height / 2
        navigateBtn.configuration = config
        
        navigateBtn.configurationUpdateHandler = { navigateBtn in
            navigateBtn.alpha = navigateBtn.isHighlighted ? 0.6 : 1
        }
        
        return navigateBtn
    } ()
    
    var listBtn: UIButton = {
        let listBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.lightGray
        config.imagePlacement = .all
        config.image = Images.listBullet
        config.automaticallyUpdateForSelection = true
        listBtn.configuration = config

        // highlighted update.
        listBtn.configurationUpdateHandler = { listBtn in
            listBtn.alpha = listBtn.isHighlighted ? 0.5 : 1
        }
        return listBtn
    } ()
    
    var listClipboardBtn: UIButton = {
        let listClipboardBtn: UIButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Colors.lightGray
        config.imagePlacement = .all
        config.image = Images.listClipboard
        config.automaticallyUpdateForSelection = true
        listClipboardBtn.configuration = config
        
        // highlighted update.
        listClipboardBtn.configurationUpdateHandler  = { listClipboardBtn in
            listClipboardBtn.alpha = listClipboardBtn.isHighlighted ? 0.5 : 1
        }
        return listClipboardBtn
    } ()
    
    
    // MARK: - Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchYoubikeData()   // Fetch Youbike data.
        addTargets()         // Add targets include btns, textFields.
        tapTheView ()        // Tap the view.
        configureScaleView() // Add the scale view in the mapView.
        
        print("mapVC viewDidLoad")
        
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("DEBUG PRINT: did Receive Memory Warning")
    }
    
    // MARK: - Configure Scale View
    func configureScaleView () {
        // By default, `MKScaleView` uses adaptive visibility, so it only displays when zooming the map.
        // This is behavior is confirgurable with the `scaleVisibility` property.
        scaleView = MKScaleView(mapView: mapView)
        scaleView.scaleVisibility = .adaptive
        scaleView.legendAlignment = .trailing
        mapView.addSubview(scaleView)
        
        scaleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scaleView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -120),
            scaleView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -30)
        ])
    }
    
    // MARK: - Add Tap Gesture
    func tapTheView () {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTheView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Add Targets
    func addTargets () {
        listClipboardBtn.addTarget(self, action: #selector(listClipboardBtnTapped), for: .touchUpInside)
        listBtn.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
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
        
        // Add informationView delegate.
        informationView.delegate = self
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
        listClipboardBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        listClipboardBtn.heightAnchor.constraint(equalTo: listClipboardBtn.widthAnchor, multiplier: 1).isActive = true
        listBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        listBtn.heightAnchor.constraint(equalTo: listBtn.widthAnchor, multiplier: 1).isActive = true
        
        searchStackView.axis = .horizontal
        searchStackView.distribution = .equalSpacing
        searchStackView.alignment    = .center
        searchStackView.spacing = 8
        searchStackView.addArrangedSubview(listBtn)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(listClipboardBtn)
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
    
    // MARK: Constraints navigateBTn
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
    // Tap the view, and move the button when the informationView disppear.
    @objc func tappedTheView (_ sender: UITapGestureRecognizer) {
        informationView.isHidden = true
        searchStackView.isHidden = true
        navigateBtn.isHidden     = false
        moveButton()
        searchTextField.resignFirstResponder()
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
    
    @objc func listClipboardBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: listClipboardBtnTapped")
        let favoriteListVC = FavoriteListViewController()
        favoriteListVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(favoriteListVC, animated: true)
    }
    
    @objc func listBtnTapped (_ sender: UIButton) {
        print("DEBUG PRINT: listBtnTapped")
        
        let sideVC = SideViewController()
        sideVC.modalPresentationStyle = .overFullScreen
        slideInTransitioningDelegate = SlideInTransitioningDelegate()
        sideVC.transitioningDelegate = slideInTransitioningDelegate
        self.present(sideVC, animated: true, completion: nil)
    }
    
    // MARK: - Set up mapView:
    func setMapView () {
        setupMapView         ()
        setupLocationManager ()
        constraintMapView    ()
    }
    
    // MARK: 設定Location Manager
    func setupLocationManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        mapView.showsUserLocation = true
    }
    
    // MARK: Set up MapView detail.
    func setupMapView () {
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate         = self
        mapView.mapType           = .standard
        mapView.isZoomEnabled     = true
        mapView.isScrollEnabled   = true
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(
            latitude: 25.0474,
            longitude: 121.5171
        ), latitudinalMeters: 250, longitudinalMeters: 250)
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
        self.view.addSubview(informationView)
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
        
        self.view.addSubview(searchStackView)
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),            searchStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchStackView.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    // MARK: - Call Location Manager:
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("DEBUG PRINT:  locationManager DidChangeAuthorization")
    }
    
    func savePlaceToCoreData(annotation: YoubikeAnnotation) {
        let favoritePlace = FavoriteListData(context: context)
        favoritePlace.stationName = annotation.title ?? "" // stationName in YoubikeAnnotation.
        favoritePlace.bikeQty     = String(annotation.stationData.sbi)  // 車輛數
        favoritePlace.dockQty     = String(annotation.stationData.bemp) // 空位站數
        favoritePlace.address     = annotation.stationData.ar           // 地址
        
        do {
            try context.save()
            print("Context saved")
        } catch {
            print("Failed to save place")
        }
    }
}

// MARK: - MKMapViewDelegate:
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        print("mapView didSelect")
        
        if let youbikeAnnotation = view.annotation as? YoubikeAnnotation {
            // Station's location.
            let stationLocation = CLLocation(latitude: youbikeAnnotation.coordinate.latitude, longitude: youbikeAnnotation.coordinate.longitude)
            
            // 用currentUserLocation去存取currentUserLocation.
            if let currentUserLocation = self.currentUserLocation {
                let distance = currentUserLocation.distance(from: stationLocation)
                print("目前距離：\(Int(distance))公尺")
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
            
            // Hide the components.
            informationView.isHidden = false
            navigateBtn.isHidden     = false
            searchStackView.isHidden = false
            
            // Update the navigationBtn from previous setting.
            navigateBtnBottomConstraint.constant = -120
            
            // For navigate the user by routeButtonTapped.
            let didSelectedtLat = youbikeAnnotation.coordinate.latitude
            let didSelectedLng  = youbikeAnnotation.coordinate.longitude
            
            didSelectedLocation    = CLLocationCoordinate2D(latitude: didSelectedtLat, longitude: didSelectedLng)
            didSelectedStationName = youbikeAnnotation.stationData.sna.replacingOccurrences(of: "_", with: "")
            
            // Stored the selected data for annotation.
            self.selectedPlaces = youbikeAnnotation
            
            print("""
             DEBUG PRINT:
             didSelect annotation:
             didSelectedLat: \(didSelectedtLat),
             didSelectedLng: \(didSelectedLng),
             stationName:    \(youbikeAnnotation.stationData.sna)
             """)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let youbikeAnnotation = annotation as? YoubikeAnnotation {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: youbikeAnnotation) as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            
            // 设置颜色逻辑
            switch youbikeAnnotation.stationData.sbi {
            case 0:
                view.markerTintColor = Colors.red
            case 1...5:
                view.markerTintColor = Colors.orange
            default:
                view.markerTintColor = Colors.green
            }
            
            view.glyphImage = Images.bike // 设置标注图标
            return view
        }
        return nil
    }
}


// MARK: - CLLocationManagerDelegate:
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the latest coordinate from location.
        currentUserLocation = locations.last
        
        // Get the latest coordinate in locations of array.
        currentCoordinates  = locations.first?.coordinate
        
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
        textField.becomeFirstResponder()
        print("DEBUG PRINT: textFieldShouldBeginEditing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("DEBUG PRINT: textFieldShouldReturn")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        print("DEBUG PRINT: textFieldDidEndEditing")
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
