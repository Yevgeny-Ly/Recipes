// MarkerLocationViewController.swift
// Copyright © RoadMap. All rights reserved.

import GoogleMaps
import UIKit

/// Экран деталей маркера локации
class MarkerLocationViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let verdanaFont = "Verdana"
        static let verdanaBoldFont = "Verdana-Bold"
        static var bonusTitleDiscount = "Your discount -30%"
        static var bonusTitleDiscriptions = "Promocode RECIPE30"
        static var promoCodeTitle = "RECIPE30"
    }

    // MARK: - Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .textGeolocation
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()

    private let markerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaBoldFont, size: 20)
        label.textAlignment = .center
        label.textColor = .textGeolocation
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGeolocation
        label.font = UIFont(name: Constants.verdanaFont, size: 20)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let discountLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont(name: Constants.verdanaFont, size: 16)
        text.text = Constants.bonusTitleDiscount
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    private let discriptionDiscountLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont(name: Constants.verdanaFont, size: 16)
        text.text = Constants.bonusTitleDiscriptions
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false

        let attributedString = NSMutableAttributedString(string: Constants.bonusTitleDiscriptions)
        let range = (Constants.bonusTitleDiscriptions as NSString).range(of: Constants.promoCodeTitle)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: range)

        text.attributedText = attributedString
        return text
    }()

    // MARK: - Public Properties

    var marker: GMSMarker?

    // MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        addSubview()
        configureView()
    }

    private func configureView() {
        markerLabel.text = marker?.title
        adressLabel.text = marker?.snippet
    }

    private func addSubview() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(markerLabel)
        view.addSubview(adressLabel)
        view.addSubview(discountLabel)
        view.addSubview(discriptionDiscountLabel)
    }

    private func setupConstraints() {
        closeButtonConstraints()
        markerLabelConstraints()
        adressLabelConstraints()
        discountLabelConstraints()
        discriptionDiscountLabelConstraints()
    }

    @objc private func closeViewController() {
        dismiss(animated: true)
        marker?.icon = GMSMarker.markerImage(with: .none)
    }
}

// MARK: - Extension + Constraints

extension MarkerLocationViewController {
    func markerLabelConstraints() {
        markerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        markerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        markerLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        markerLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    func adressLabelConstraints() {
        adressLabel.topAnchor.constraint(equalTo: markerLabel.bottomAnchor, constant: 10).isActive = true
        adressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        adressLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        adressLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    func discountLabelConstraints() {
        discountLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 40).isActive = true
        discountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        discountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        discountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        discountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func discriptionDiscountLabelConstraints() {
        discriptionDiscountLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 15).isActive = true
        discriptionDiscountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        discriptionDiscountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .isActive = true
        discriptionDiscountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .isActive = true
        discriptionDiscountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func closeButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 13).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
}
