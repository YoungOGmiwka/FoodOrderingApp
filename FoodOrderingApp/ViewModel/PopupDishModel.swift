//
//  PopupDishModel.swift
//  FoodOrderingApp
//
//  Created by Михаил on 13.07.2023.
//

import SwiftUI

class PopupDishModel: ObservableObject {
    
    @Published var showPopup = false
    
    @Published var selectedDish : Dishes!
}
