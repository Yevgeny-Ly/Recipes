// UserProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import GoogleMaps
import UIKit

/// Координатор для  профиля
final class UserProfileCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?

    func setRootController(viewController: UIViewController) {
        rootViewController = UINavigationController(rootViewController: viewController)
    }

    func pushMapView() {
        let ourPartnersViewController = OurPartnersViewController()
        let ourPartnersPresenter = OurPartnersPresenter(view: ourPartnersViewController, coordinator: self)
        ourPartnersViewController.presenter = ourPartnersPresenter
        ourPartnersViewController.modalPresentationStyle = .fullScreen
        rootViewController?.pushViewController(ourPartnersViewController, animated: true)
    }

    func dissmiss() {
        rootViewController?.popViewController(animated: true)
    }

    func pushDetailViewController(marker: GMSMarker) {
        let markerLocationViewController = MarkerLocationViewController()
        markerLocationViewController.marker = marker

        if let sheetPresentationController = markerLocationViewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheetPresentationController.detents = [.custom(resolver: { _ in
                    300
                })]
            } else {
                sheetPresentationController.detents = [.medium()]
            }
            sheetPresentationController.preferredCornerRadius = 30
            sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.prefersEdgeAttachedInCompactHeight = true
        }

        rootViewController?.present(markerLocationViewController, animated: true)
    }
}
