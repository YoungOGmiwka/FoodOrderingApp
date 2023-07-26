//
//  CategoryResultState.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import Foundation

enum CategoryResultState {
    case loading
    case success(content: [Сategory])
    case failed(error: Error)
}
