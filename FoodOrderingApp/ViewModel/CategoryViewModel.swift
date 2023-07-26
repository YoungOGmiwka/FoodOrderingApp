//
//  CategoryViewModel.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import Foundation
import Combine

protocol ICategoryViewModel {
    func getFoodCategory()
}

class CategoryViewModelImpl: ObservableObject, ICategoryViewModel {
    
    private let service: CategoryService
    
    private(set) var сategories = [Сategory]()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: CategoryResultState = .loading
    
    init(service: CategoryService) {
        self.service = service
    }
    
    func getFoodCategory() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getCategories)
            .sink { res in
                switch res {
                    
                case .finished:
                    self.state = .success(content: self.сategories)
                break
                case .failure(let error):
                    self.state = .failed(error: error)
                break
                }
            } receiveValue: { response in
                self.сategories = response.сategories
            }
        
        self.cancellables.insert(cancellable)
    }
}
