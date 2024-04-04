// MVPUITested.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

// swiftlint:disable all

final class MVPUITested: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func check(textID: String) {
        app.launch()
        guard app.staticTexts[textID].exists else {
            XCTFail("Текст отсутствует \(textID)")
            return
        }
    }

    /// Тестируется раздел авторизации
    func testFillingsAutorization() {
        /// Проверка слова Login в блоке авторизации
        check(textID: "Login")
        /// Проверка слова Password в блоке авторизации
        check(textID: "Password")
        /// Проверка слова Email Address в блоке авторизации
        check(textID: "Email Address")
    }

    func testValidLoginSuccess() {
        let app = XCUIApplication()

        /// Валидные дынне для имени пользователя
        let validUserName = "@"

        /// Валидные дынне для пароля пользователя
        let validPassword = "111111"

        /// Нахождение текстового поля с идентификатором мэила
        let userNameTextField = app.textFields["Enter Email Address"]

        /// Проверка на существование данного поля
        XCTAssertTrue(userNameTextField.exists)

        /// Нажатие на текстовое поле
        userNameTextField.tap()

        /// Ввод текста в поле
        userNameTextField.typeText(validUserName)

        /// Нахождение текстового поля с идентификатором пароля
        let enterPasswordSecureTextField = app.secureTextFields["Enter Password"]

        /// Проверка на существование данного поля
        XCTAssertTrue(enterPasswordSecureTextField.exists)

        /// Нажатие на текстовое поле
        enterPasswordSecureTextField.tap()

        /// Ввод текста в поле
        enterPasswordSecureTextField.typeText(validPassword)

        /// Нажатие на кнопку входа
        app.buttons["Login"].staticTexts["Login"].tap()

        testeRecipiesScreen(app: app)
    }

    func testeRecipiesScreen(app: XCUIApplication) {
        /// Нахождение текста в коллекции
        let dowloadCellElement = app.collectionViews.staticTexts["chicken"]

        /// Создание expectation
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: dowloadCellElement, handler: nil)

        /// Ожидание выполнения проверки
        waitForExpectations(timeout: 15)

        /// Проверка на сузествование элемента dowloadCell
        XCTAssertTrue(dowloadCellElement.exists)

        /// Нажатие на элемент
        dowloadCellElement.tap()

        /// Свайп по ячейке
        app.tables.cells.containing(.staticText, identifier: "Pressure-Cooker Octopus Recipe")
            .children(matching: .other).element(boundBy: 1).swipeUp()

        /// Поиск ячейке с нужным текстом и нажатие на нее
        app.tables.cells.containing(.staticText, identifier: "Nigerian Lafun")
            .children(matching: .other).element(boundBy: 1).tap()
    }
}

// swiftlint:enable all
