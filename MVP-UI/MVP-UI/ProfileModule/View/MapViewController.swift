// MapViewController.swift
// Copyright © RoadMap. All rights reserved.

import CoreLocation
import GoogleMaps
import UIKit

/// Экран карт
final class MapViewController: UIViewController {
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var markers: [GMSMarker] = []

    private lazy var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 43.1014, longitude: 132.3435, zoom: 13.0)
        let mapView = GMSMapView()
        mapView.camera = camera
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .logInButtonColor(alpha: 1)
        button.tintColor = .white
        button.setTitle("Ok", for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var giftsLabel: UILabel = {
        let label = UILabel()
        label.text = "You can get gifts and discounts from our partners"
        label.numberOfLines = 0
        return label
    }()

    private lazy var locationButton: UIButton = {
        let button = UIButton()
        let buttonSize: CGFloat = 52
        let buttonImage = UIImage(named: "location")
        button.setImage(buttonImage, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = buttonSize / 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        showLondonLocation()
        mapView.delegate = self
        addStaticMarkers()

        setupNavigationBar()
        view.addSubview(mapView)
        view.addSubview(okButton)
        makeOkButtonAnchor()
        view.addSubview(giftsLabel)
        makeGiftsLabelAnchor()
        view.addSubview(locationButton)
        makeLocationButtoAnchor()

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 113),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -275)
        ])
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Our Partners"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: false)
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let closeBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }

    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func okButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func locationButtonTapped() {
        locationManager.startUpdatingLocation()
        locationButton.setImage(UIImage(named: "location_filled"), for: .normal)
    }

    private func showLondonLocation() {
        let londonCoordinate = CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337)
        updateMapLocation(londonCoordinate)
    }

    private func addStaticMarkers() {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 43.1014, longitude: 132.3435),
            CLLocationCoordinate2D(latitude: 43.105, longitude: 132.34),
            CLLocationCoordinate2D(latitude: 43.11, longitude: 132.348),
            CLLocationCoordinate2D(latitude: 43.095, longitude: 132.335),
            CLLocationCoordinate2D(latitude: 43.1, longitude: 132.355),
            CLLocationCoordinate2D(latitude: 43.098, longitude: 132.345),
            CLLocationCoordinate2D(latitude: 43.106, longitude: 132.355)
        ]

        for coordinate in coordinates {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            markers.append(marker)
        }
    }

    private func makeOkButtonAnchor() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71).isActive = true
        okButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makeGiftsLabelAnchor() {
        giftsLabel.translatesAutoresizingMaskIntoConstraints = false
        giftsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        giftsLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -60).isActive = true
        giftsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        giftsLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func makeLocationButtoAnchor() {
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.widthAnchor.constraint(equalToConstant: 52).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250)
            .isActive = true
        locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        currentLocation = newLocation
        updateMapLocation(newLocation.coordinate)
        print("Updated location: \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")

        let marker = GMSMarker(position: newLocation.coordinate)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    private func updateMapLocation(_ coordinate: CLLocationCoordinate2D) {
        var bounds = GMSCoordinateBounds()
        for marker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }

        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: cameraUpdate)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        locationButton.setImage(UIImage(named: "location"), for: .normal)
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if markers.contains(marker) {
            // Показать модальное всплывающее окно
            showPopupView(for: marker)
            print("gggfgfgfggf")
            return true
        }
        return false
    }

    private func showPopupView(for marker: GMSMarker) {
        // Создание экземпляра модального контроллера
        let popupViewController = MarkerPopupViewController()

        // Передача данных о маркере в модальное окно (если необходимо)
//        popupViewController.markerTitle = "Title" // Замените на данные маркера
//        popupViewController.markerDescription = "Description" // Замените на данные маркера

        // Отображение модального окна
        present(popupViewController, animated: true, completion: nil)
    }
}
