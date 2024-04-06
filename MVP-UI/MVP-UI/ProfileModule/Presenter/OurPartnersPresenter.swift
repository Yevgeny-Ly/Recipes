// OurPartnersPresenter.swift
// Copyright © RoadMap. All rights reserved.

import GoogleMaps
import UIKit

/// Протокол презентора гугл карт
protocol OurPartnersPresenterProtocol {
    /// Открытие детального экрана маркера
    func pushDetailMarker(marker: GMSMarker)
    /// Закрывает экран
    func dissmiss()
}

/// Презентер гугл карт
final class OurPartnersPresenter {
    private weak var view: OurPartnersViewController?
    private weak var coordinator: UserProfileCoordinator?

    init(view: OurPartnersViewController?, coordinator: UserProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - OurPartnersPresenter + OurPartnersPresenterProtocol

extension OurPartnersPresenter: OurPartnersPresenterProtocol {
    func pushDetailMarker(marker: GMSMarker) {
        coordinator?.pushDetailViewController(marker: marker)
    }

    func dissmiss() {
        coordinator?.dissmiss()
    }
}
