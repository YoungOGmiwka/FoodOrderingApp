//
//  CategoryService.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import Foundation
import Combine

protocol CategoryService {
    func request(from endpoint: CategoryAPI) -> AnyPublisher<FoodCategoryResponse, APIError>
}

struct CategoriesServiceImpl: CategoryService {
    
    func request(from endpoint: CategoryAPI) -> AnyPublisher<FoodCategoryResponse, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<FoodCategoryResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail (error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: FoodCategoryResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                        
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
