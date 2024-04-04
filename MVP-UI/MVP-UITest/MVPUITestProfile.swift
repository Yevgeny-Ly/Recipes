// MVPUITestProfile.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MVPUITestProfile: XCTestCase {
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

    /// Отображение экрана профиля
    func testDisplayProfileScreen() throws {
        // Нажатие на вкладку "Profile" в таб-баре
        app.tabBars.buttons["Profile"].tap()
        // Проверка существования навигационного бара с заголовком "Profile"
        XCTAssertTrue(app.navigationBars["Profile"].exists)
    }

    /// Изменение имени пользователя
    func testChangeUserName() throws {
        // Нажатие на вкладку "Profile" в таб-баре
        app.tabBars.buttons["Profile"].tap()

        // Взаимодействие с элементами алерта для изменения имени пользователя
        let nameSurnameTextField = XCUIApplication().alerts["Change your name and surname"].scrollViews.otherElements
            .collectionViews.textFields["Name Surname"]
        XCUIApplication().tables.buttons["editingIcon"].tap()
        nameSurnameTextField.typeText("Test Name")
        XCUIApplication().alerts["Change your name and surname"].scrollViews.otherElements.buttons["Ok"].tap()
        // Проверка отображения нового имени пользователя
        XCTAssertTrue(app.staticTexts["Test Name"].exists)
    }

    /// Появление алерта с бонусами
    func testBonusesAlert() throws {
        // Нажатие на вкладку "Profile" в таб-баре
        app.tabBars.buttons["Profile"].tap()
        // Проверка существования текста "Bonuses" в таблице
        XCTAssertTrue(
            app.tables.staticTexts["Bonuses"].exists
        )
        // Нажатие на ячейку с изображением бонусов
        app.tables.staticTexts["Bonuses"].tap()

        // Проверка отображения экрана с бонусами
        let bonusesScreen = XCUIApplication().windows.children(matching: .other).element(boundBy: 1)
            .children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
            .children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(bonusesScreen.exists)
        // Нажатие кнопки "closeButton"
        app.buttons["closeButton"].tap()
    }

    /// Появление алерта с условиями и политикой конфиденциальности
    func testTermsAlert() throws {
        // Нажатие на вкладку "Profile" в таб-баре
        app.tabBars.buttons["Profile"].tap()
        // Проверка существования текста "Terms & Privacy Policy" в таблице
        XCTAssertTrue(app.tables.staticTexts["Terms & Privacy Policy"].exists)
        // Нажатие на ячейку с текстом "Terms & Privacy Policy"
        app.tables.staticTexts["Terms & Privacy Policy"].tap()
        // Прокрутка вверх для просмотра всего содержимого
        app.otherElements.containing(.image, identifier: "penHandle").children(matching: .other).element
            .swipeUp()
        // Проверка отображения текста "Terms of Use"
        XCTAssertTrue(app.staticTexts["Terms of Use"].exists)
        // Нажатие кнопки "closeButton"
        app.buttons["closeButton"].tap()
    }
}
