//
//  CategoryEndpoint.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum CategoryAPI {
    case getCategories
}

extension CategoryAPI: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getCategories:
            return URL(string: "https://run.mocky.io")!
        }
    }
    
    var path: String {
        return "/v3/058729bd-1402-4578-88de-265481fd7d54"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
}
