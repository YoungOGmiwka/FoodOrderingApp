//
//  DishesViewModel.swift
//  FoodOrderingApp
//
//  Created by Михаил on 07.07.2023.
//

import Foundation
import Combine

protocol IDishesViewModel {
    func getFoodDishes()
}

class DishesViewModelImpl: ObservableObject, IDishesViewModel {
    
    private let service: DishesService
    
    private(set) var dishes = [Dishes]()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: DishesResultState = .loading
    
    
    
    init(service: DishesService) {
        self.service = service
    }
    
    func getFoodDishes() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getDishes)
            .sink { res in
                switch res {
                    
                case .finished:
                    self.state = .success(content: self.dishes)
                break
                case .failure(let error):
                    self.state = .failed(error: error)
                break
                }
            } receiveValue: { response in
                self.dishes = response.dishes
            }
        
        self.cancellables.insert(cancellable)
    }
}
