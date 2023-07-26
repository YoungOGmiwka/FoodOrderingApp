//
//  CartViewModel.swift
//  FoodOrderingApp
//
//  Created by Михаил on 18.07.2023.
//

import SwiftUI

class CartViewModel: ObservableObject {
    
    @Published var selectedItems = [Dishes]()
    
    func add(item: Dishes) {
        selectedItems.append(item)
    }
    
    func decrease(item: Dishes) {
        if let index = selectedItems.firstIndex(of: item) {
            selectedItems.remove(at: index)
        }
    }
    
    func calculateTotalPrice() -> Int {
        if selectedItems.count > 0 {
            return selectedItems.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
}
