// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Swinject
import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    private var tabBarViewController = TabBarController()
    private var appBuilder: AppBulder
    private var container: Container

    init(appBuilder: AppBulder, container: Container) {
        self.appBuilder = appBuilder
        self.container = container
    }

    override func start() {
//        toAutorization()
        tabBarMain()
    }

    private func tabBarMain() {
        guard let networkService = container.resolve(NetworkService.self),
              let coreDataManager = container.resolve(CoreDataManager.self) else { return }
        let recipesCoordinator = RecipesCoordinator(networkService: networkService, coreDataManager: coreDataManager)
        let recipesModule = appBuilder.makeRecipesViewController(recipecCoordinator: recipesCoordinator)
        recipesCoordinator.setRootController(viewController: recipesModule)
        add(coordinator: recipesCoordinator)

        let favoriteCoordinator = FavoritesCoordinator(networkService: networkService)
        let favoritesModule = appBuilder.makeFavoritesViewController(favoritesCoordinator: favoriteCoordinator)
        favoriteCoordinator.setRootController(viewController: favoritesModule)
        add(coordinator: favoriteCoordinator)

        let userCoordinator = UserProfileCoordinator()
        let userProfileModule = appBuilder.makeUserProfileViewController(userProfileUserCoordinator: userCoordinator)
        userCoordinator.setRootController(viewController: userProfileModule)
        add(coordinator: userCoordinator)

        guard let recipesRootViewController = recipesCoordinator.rootViewController else { return }
        guard let favoriteViewController = favoriteCoordinator.rootViewController else { return }
        guard let userViewController = userCoordinator.rootViewController else { return }

        tabBarViewController.setViewControllers(
            [
                recipesRootViewController,
                favoriteViewController,
                userViewController
            ],
            animated: false
        )
        let tabBarViewController = tabBarViewController

        setAsRoot​(​_​: tabBarViewController)
    }

    private func toAutorization() {
        let autorizationCoordinator = AutorizationCoordinator()
        autorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.tabBarMain()
        }
        add(coordinator: autorizationCoordinator)
        autorizationCoordinator.start()
    }
}
