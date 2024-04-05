// MapViewController.swift
// Copyright © RoadMap. All rights reserved.

import GoogleMaps
import UIKit

/// Экран карт
final class MapViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.addSubview(mapView)
        view.addSubview(okButton)
        makeOkButtonAnchor()
        view.addSubview(giftsLabel)
        makeGiftsLabelAnchor()

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
}
