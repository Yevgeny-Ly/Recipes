// MVPUITests.swift
// Copyright © RoadMap. All rights reserved.

import XCTest

final class MVPUITests: XCTestCase {
    var networkService: NetworkServiceProtocol?
    var networtCreatorFail: RequestCreatorProtocol?

    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        networtCreatorFail = MockRequest()
    }

    override func tearDown() {
        networkService = nil
        networtCreatorFail = nil
        super.tearDown()
    }

    func testGetRecipeSuccess() {
        let expectation = XCTestExpectation()

        networkService?.getRecipe(type: .chicken) { result in
            switch result {
            case let .success(recipies):
                XCTAssertEqual(recipies.count, 2)
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation])
    }

    func testGetRecipeFailure() {
        let expectation = XCTestExpectation()

        networtCreatorFail?.getRecipe(type: .chicken) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation])
    }

    func testGetDetailSuccess() {
        let expectation = XCTestExpectation()

        networkService?
            .getDetail(
                uri: "https://api.edamam.com/api/recipes/v2?app_id=9b070203&app_key=432a035bdb4cc9008e4fbb1fe17990bb&type=public&dishType=main%20course&q=Chicken"
            ) { result in
                switch result {
                case let .success(result):
                    XCTAssertEqual(result.label, "запрос выполнен")
                    expectation.fulfill()
                case let .failure(error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }

        wait(for: [expectation], timeout: 5)
    }

    func testGetDetailFailure() {
        let expectation = XCTestExpectation()

        networkService?.getDetail(uri: "error") { result in
            switch result {
            case .success:
                expectation.fulfill()
            case let .failure(error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5)
    }
}
