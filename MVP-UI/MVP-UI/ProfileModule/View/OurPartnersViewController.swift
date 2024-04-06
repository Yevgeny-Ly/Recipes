// OurPartnersViewController.swift
// Copyright © RoadMap. All rights reserved.

import CoreLocation
import GoogleMaps
import UIKit

/// Протокол экрана гугл карт
protocol OurPartnersProtocol: AnyObject {}

/// Экран гугл карт
final class OurPartnersViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let verdanaFont = "Verdana"
        static let verdanaBoldFont = "Verdana-Bold"
        static let ourPartnersTitle = "Our Partners"
        static let okButtonTitle = "Ok"
    }

    // MARK: - Visual Components

    private let ourPartnersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.verdanaBoldFont, size: 20)
        label.text = Constants.ourPartnersTitle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let giftsDiscountsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.verdanaFont, size: 18)
        label.text = Local.OurPartnersViewController.giftsDiscountsTitle
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .buttonOurPartners
        button.setTitle(Constants.okButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()

    private let panelViewLocation: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.locationNotPress, for: .normal)
        button.tintColor = .buttonLocation
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnsUserGeolocation), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Properties

    var presenter: OurPartnersPresenter?

    // MARK: - Private Properties

    private lazy var marker = GMSMarker()
    private var mapView = GMSMapView()
    private let mapOptions = GMSMapViewOptions()
    private var locationManager = CLLocationManager()
    private var nextUserLocation: CLLocation = .init(latitude: 44.948239, longitude: 34.100325)

    // MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        panelViewLocation.layer.cornerRadius = panelViewLocation.frame.width / 2
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        configureNavigationController()
        configureLocationManager()
        configureOptions()
        coonfigureMapView()
        addSubview()
        configureMap()
    }

    private func configureNavigationController() {
        navigationItem.hidesBackButton = true
        navigationController?.tabBarController?.tabBar.isHidden = true

        let closeButton = UIBarButtonItem(
            image: .closeButton,
            style: .plain,
            target: self,
            action: #selector(closeViewController)
        )

        closeButton.tintColor = .black
        navigationItem.rightBarButtonItem = closeButton
    }

    private func configureOptions() {
        mapOptions.camera = GMSCameraPosition(target: nextUserLocation.coordinate, zoom: 12)
        marker.position = nextUserLocation.coordinate
        mapOptions.frame = view.bounds
    }

    private func coonfigureMapView() {
        mapView = GMSMapView(options: mapOptions)
        mapView.delegate = self
        marker.map = mapView
    }

    private func configureLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        guard let location = locationManager.location else { return }
        nextUserLocation = location
    }

    private func configureMap() {
        let coordinateCulturalPark = CLLocationCoordinate2D(latitude: 44.964279, longitude: 34.097882)
        let markerCulturalPark = GMSMarker(position: coordinateCulturalPark)
        markerCulturalPark.title = "Парк культуры"
        markerCulturalPark.snippet = "Симферополь, ул. Троллейбусная 12"

        let coordinateCafeChao = CLLocationCoordinate2D(latitude: 44.955439, longitude: 34.104773)
        let markerCafeChao = GMSMarker(position: coordinateCafeChao)
        markerCafeChao.title = "Кафе Чао"
        markerCafeChao.snippet = "Симферополь, ул. Ухтомская 76"

        let coordinatePlant = CLLocationCoordinate2D(latitude: 44.946743, longitude: 34.067593)
        let markerPlant = GMSMarker(position: coordinatePlant)
        markerPlant.title = "Завод"
        markerPlant.snippet = "Симферополь, ул. Кирова 122"

        let orphanage = CLLocationCoordinate2D(latitude: 44.911756, longitude: 34.092733)
        let markerOrphanage = GMSMarker(position: orphanage)
        markerOrphanage.title = "Дествкий дом"
        markerOrphanage.snippet = "Симферополь, пер. Жигулин 87"

        let terskayaVillage = CLLocationCoordinate2D(latitude: 44.941042, longitude: 34.145777)
        let markerTerskayaVillage = GMSMarker(position: terskayaVillage)
        markerTerskayaVillage.title = "Станица Терская"
        markerTerskayaVillage.snippet = "Терска, ул. Вавилова 16"

        let derzhavnayaChurch = CLLocationCoordinate2D(latitude: 44.977330, longitude: 34.130283)
        let markerDerzhavnayaChurch = GMSMarker(position: derzhavnayaChurch)
        markerDerzhavnayaChurch.title = "Державная церковь"
        markerDerzhavnayaChurch.snippet = "Симферополь, ул. Гоголя 119"

        markerCulturalPark.map = mapView
        markerCafeChao.map = mapView
        markerPlant.map = mapView
        markerOrphanage.map = mapView
        markerTerskayaVillage.map = mapView
        markerDerzhavnayaChurch.map = mapView
    }

    private func addSubview() {
        view.addSubview(ourPartnersLabel)
        view.addSubview(giftsDiscountsLabel)
        view.addSubview(okButton)
        view.addSubview(mapView)
        mapView.addSubview(panelViewLocation)
        panelViewLocation.addSubview(locationButton)
    }

    private func setupConstraints() {
        ourPartnersLabelConstraints()
        giftsDiscountsLabelConstraints()
        okButtonConstraintsConstraints()
        mapViewConstraints()
        panelViewLocationConstraints()
        locationButtonConstraints()
    }

    @objc private func closeViewController() {
        presenter?.dissmiss()
    }

    @objc private func returnsUserGeolocation() {
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            nextUserLocation = location
        }

        marker.icon = GMSMarker.markerImage(with: .blue)
        locationButton.setImage(.locationPress, for: .normal)

        if let locationManager = locationManager.location?.coordinate {
            mapView.animate(toLocation: locationManager)
            marker.position = locationManager
            mapView.animate(toZoom: 12)
        }
    }
}

// MARK: - Extension + Constraints

extension OurPartnersViewController {
    private func ourPartnersLabelConstraints() {
        ourPartnersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        ourPartnersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ourPartnersLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        ourPartnersLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func mapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: ourPartnersLabel.bottomAnchor, constant: 20).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 456).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func giftsDiscountsLabelConstraints() {
        giftsDiscountsLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 40).isActive = true
        giftsDiscountsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        giftsDiscountsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        giftsDiscountsLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func okButtonConstraintsConstraints() {
        okButton.topAnchor.constraint(equalTo: giftsDiscountsLabel.bottomAnchor, constant: 40).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    private func panelViewLocationConstraints() {
        panelViewLocation.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10).isActive = true
        panelViewLocation.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -15).isActive = true
        panelViewLocation.heightAnchor.constraint(equalToConstant: 52).isActive = true
        panelViewLocation.widthAnchor.constraint(equalToConstant: 52).isActive = true
    }

    private func locationButtonConstraints() {
        locationButton.centerXAnchor.constraint(equalTo: panelViewLocation.centerXAnchor).isActive = true
        locationButton.centerYAnchor.constraint(equalTo: panelViewLocation.centerYAnchor).isActive = true
    }
}

// MARK: - Extension + GMSMapViewDelegate

extension OurPartnersViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        locationButton.setImage(.locationNotPress, for: .normal)
        marker.icon = GMSMarker.markerImage(with: .none)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.title ?? GMSMarker())
        presenter?.pushDetailMarker(marker: marker)
        marker.icon = GMSMarker.markerImage(with: .blue)
        return true
    }
}

// MARK: - Extension + CLLocationManagerDelegate

extension OurPartnersViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - Extension + OurPartnersProtocol

extension OurPartnersViewController: OurPartnersProtocol {}
