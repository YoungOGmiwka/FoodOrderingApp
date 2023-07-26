//
//  DishesResultState.swift
//  FoodOrderingApp
//
//  Created by Михаил on 07.07.2023.
//

import Foundation

enum DishesResultState {
    case loading
    case success(content: [Dishes])
    case failed(error: Error)
}
