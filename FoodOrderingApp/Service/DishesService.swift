//
//  DishesService.swift
//  FoodOrderingApp
//
//  Created by Михаил on 07.07.2023.
//

import Foundation
import Combine

protocol DishesService {
    func request(from endpoint: DishesAPI) -> AnyPublisher<FoodDishesResponse, APIError>
}

struct DishesServiceImpl: DishesService {
    
    func request(from endpoint: DishesAPI) -> AnyPublisher<FoodDishesResponse, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<FoodDishesResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail (error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: FoodDishesResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                        
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
}
