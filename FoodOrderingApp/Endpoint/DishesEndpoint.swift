//
//  DishesEndpoint.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import Foundation

enum DishesAPI {
    case getDishes
}

extension DishesAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getDishes:
            return URL(string: "https://run.mocky.io")!
        }
    }
    
    var path: String {
        return "/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
}
