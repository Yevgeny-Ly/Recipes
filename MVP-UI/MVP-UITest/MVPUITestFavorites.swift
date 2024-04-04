// MVPUITestFavorites.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MVPUITestFavorites: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    /// Проверка пустого экрана избранных
    func testEmptyFavoritesView() throws {
        /// Нажатие на вкладку "Favorites" в таб-баре
        app.tabBars.buttons["Favorites"].tap()
        /// Проверка отсутствия изображения пустого экрана избранных
        XCTAssertTrue(app.images["emptyFavoritesImageView"].exists)
    }

    /// Интерактивное взаимодействие с экраном избранных
    func testFavoritestInteractive() throws {
        /// Нажатие на вкладку "Recipes" в таб-баре
        app.tabBars.buttons["Recipes"].tap()

        /// Нажатие на ячейку в коллекции рецептов
        app.collectionViews.buttons["soup"].tap()

        /// Нажатие на ячейку в таблице рецептов
        app.tables.cells.containing(.staticText, identifier: "Anchovy Stock Recipe")
            .children(matching: .other).element(boundBy: 1).tap()

        /// Взаимодействие с элементами навигационного бара на экране рецепта
        let recipesNavigationBar = app.navigationBars["Recipes"]
        /// Добавление в избранные
        recipesNavigationBar.buttons["noFavorite"].tap()
        /// Назад
        recipesNavigationBar.buttons["arrowBackward"].tap()

        /// Нажатие на кнопку "arrow.backward"
        recipesNavigationBar.buttons["arrow.backward"].tap()

        /// Нажатие на вкладку "Favorites" в таб-баре
        app.tabBars.buttons["Favorites"].tap()

        /// Проверка отсутствия изображения пустого экрана избранных
        XCTAssertTrue(!app.images["emptyFavoritesImageView"].exists)

        /// Проверка существования таблицы избранных рецептов
        XCTAssertTrue(app.tables["favoritesTableView"].exists)

        /// Подсчет количества ячеек в таблице
        let cellsCount = app.tables["favoritesTableView"].cells.count
        let expectedRecipesCount = 1

        /// Проверка соответствия ожидаемого количества ячеек фактическому
        XCTAssertEqual(cellsCount, expectedRecipesCount)

        /// Нажатие на ячейку в таблице избранных рецептов
        app.tables.cells.children(matching: .other).element(boundBy: 1).tap()

        /// Взаимодействие с элементами навигационного бара на экране избранных
        let favoritesNavigationBar = app.navigationBars["Favorites"]
        /// Удаление из избранных
        favoritesNavigationBar.buttons["isFavorite"].tap()
        /// Назад
        favoritesNavigationBar.buttons["arrowBackward"].tap()
    }
}
