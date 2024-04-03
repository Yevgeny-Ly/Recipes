//
//  MockRequest.swift
//  MVP-UITests
//
//

import UIKit

/// Протокол коммуникации с NetworkService
protocol RequestCreatorProtocol {
    /// получение рецептов
    func getRecipe(type: DishType, completionHandler: @escaping (Result<[RecipeCommonInfo], Error>) -> Void)
}

final class MockRequest: RequestCreatorProtocol {
    // MARK: - Constants
    
    private enum Constants {
        static let scheme = "https"
        static let host = "api.edamam.com"
        static let path = "/api/recipes/v2"
        static let detailPath = "/api/recipes/v2/by-uri"
        static let componentsTypeKey = "type"
        static let identefire = "app_id"
        static let componnentsAppKey = "app_key"
        static let componentsDishTypeKey = "dishType"
        static let type = "public"
        static let appKey = "2412c4c0d52ca924f6d6a486c1aa1ab6"
        static let appId = "a726fb9c"
        static let dishType = "dishType"
        static let uriTitle = "uri"
    }
    
    private var component = URLComponents()
    private let scheme = Constants.scheme
    private let host = Constants.host
    private let path = Constants.path

    func createURLQueryItems(type: DishType) -> [URLQueryItem] {
        [
            URLQueryItem(name: Constants.componentsTypeKey, value: Constants.type),
            URLQueryItem(name: Constants.identefire, value: Constants.appId),
            URLQueryItem(name: Constants.componnentsAppKey, value: Constants.appKey),
            URLQueryItem(name: Constants.componentsDishTypeKey, value: type.discription)
        ]
    }
    
    func createURLComponents(type: DishType) {
        component.scheme = scheme
        component.host = host
        component.queryItems = createURLQueryItems(type: type)
        component.path = path
    }

    func getRecipe(type: DishType, completionHandler: @escaping (Result<[RecipeCommonInfo], Error>) -> Void) {
        createURLComponents(type: type)
        guard let url = component.url else { return }

        guard let url = URL.makeURL(url, mockFileName: .recipies) else {
            if let error = "Отсутствует моковый файл" as? Error {
                completionHandler(.failure(error))
            }
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            if let data = data {
                do {
                    let resultDetailsDTO = try JSONDecoder().decode(RecipeResponseDTO.self, from: data)
                    let result = resultDetailsDTO.hits.map { RecipeCommonInfo(dto: $0.recipe) }
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}
