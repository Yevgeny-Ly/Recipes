// OurPartnersViewController.swift
// Copyright © RoadMap. All rights reserved.

import CoreLocation
import GoogleMaps
import UIKit

/// Экран гугл карт
class OurPartnersViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let verdanaFont = "Verdana"
        static let verdanaBoldFont = "Verdana-Bold"
        static let ourPartnersTitle = "Our Partners"
        static let okButtonTitle = "Ok"
    }

    private var locationManager: CLLocationManager?
    private lazy var coordinateLive = CLLocationCoordinate2D(latitude: 44.948239, longitude: 34.100325)
    private lazy var camera = GMSCameraPosition.camera(withTarget: coordinateLive, zoom: 12)
    private lazy var markerLive = GMSMarker(position: coordinateLive)

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

    private let mapView = GMSMapView()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
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

    // MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupConstraints()
        setupView()
        configureMap()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        panelViewLocation.layer.cornerRadius = panelViewLocation.frame.width / 2
    }

    // MARK: - Private Methods

    private func configureMap() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self

        let coordinateCulturalPark = CLLocationCoordinate2D(latitude: 44.964279, longitude: 34.097882)
        let markerCulturalPark = GMSMarker(position: coordinateCulturalPark)

        let coordinateCafeChao = CLLocationCoordinate2D(latitude: 44.955439, longitude: 34.104773)
        let markerCafeChao = GMSMarker(position: coordinateCafeChao)

        let coordinatePlant = CLLocationCoordinate2D(latitude: 44.946743, longitude: 34.067593)
        let markerPlant = GMSMarker(position: coordinatePlant)

        let orphanage = CLLocationCoordinate2D(latitude: 44.911756, longitude: 34.092733)
        let markerOrphanage = GMSMarker(position: orphanage)

        let terskayaVillage = CLLocationCoordinate2D(latitude: 44.941042, longitude: 34.145777)
        let markerTerskayaVillage = GMSMarker(position: terskayaVillage)

        let derzhavnayaChurch = CLLocationCoordinate2D(latitude: 44.977330, longitude: 34.130283)
        let markerDerzhavnayaChurch = GMSMarker(position: derzhavnayaChurch)

        markerLive.map = mapView
        markerCulturalPark.map = mapView
        markerCafeChao.map = mapView
        markerPlant.map = mapView
        markerOrphanage.map = mapView
        markerTerskayaVillage.map = mapView
        markerDerzhavnayaChurch.map = mapView
        mapView.camera = camera

        mapView.delegate = self
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func addSubview() {
        view.addSubview(ourPartnersLabel)
        view.addSubview(closeButton)
        view.addSubview(giftsDiscountsLabel)
        view.addSubview(okButton)
        view.addSubview(mapView)
        mapView.addSubview(panelViewLocation)
        panelViewLocation.addSubview(locationButton)
    }

    private func setupConstraints() {
        ourPartnersLabelConstraints()
        closeButtonConstraints()
        giftsDiscountsLabelConstraints()
        okButtonConstraintsConstraints()
        mapViewConstraints()
        panelViewLocationConstraints()
        locationButtonConstraints()
    }

    private func ourPartnersLabelConstraints() {
        ourPartnersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        ourPartnersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ourPartnersLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        ourPartnersLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func closeButtonConstraints() {
        closeButton.centerYAnchor.constraint(equalTo: ourPartnersLabel.centerYAnchor).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
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

    @objc private func closeViewController() {
        dismiss(animated: true)
    }

    @objc private func returnsUserGeolocation() {
        markerLive.icon = GMSMarker.markerImage(with: .systemBlue)
        locationButton.setImage(.locationPress, for: .normal)
    }
}

extension OurPartnersViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        markerLive.icon = GMSMarker.markerImage(with: .none)
        locationButton.setImage(.locationNotPress, for: .normal)
    }
}

extension OurPartnersViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
