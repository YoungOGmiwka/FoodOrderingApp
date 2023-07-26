//
//  DetailDishesView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 07.07.2023.
//

import SwiftUI

struct DetailDishesView: View {
    
    @StateObject var viewModel = DishesViewModelImpl(service: DishesServiceImpl())
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Namespace var animation
    
    @StateObject var popupDishData = PopupDishModel()
    @EnvironmentObject var cartData: CartViewModel

    @Binding var path: NavigationPath
    
    var columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]
    
    let categoryName: String
    
    @State private var dishTeg = Teg.allCases
    
    @State private var selectedIndex: Teg = .allMenu
    
    @State private var filteredDishes: [Dishes] = []
    
    private var dishesArray: [Dishes] {
        filteredDishes.isEmpty ? viewModel.dishes: filteredDishes
    }
    
    private func performSort(selectedIndex: Teg) {
        var allDishes = dishesArray
        
        switch selectedIndex {
            case .allMenu:
                allDishes = viewModel.dishes
                filteredDishes = allDishes.filter {$0.tegs.contains(.allMenu)}
            case .salad:
                allDishes = viewModel.dishes
                filteredDishes = allDishes.filter {$0.tegs.contains(.salad)}
            case .withRice:
                allDishes = viewModel.dishes
                filteredDishes = allDishes.filter {$0.tegs.contains(.withRice)}
            case .withFish:
                allDishes = viewModel.dishes
                filteredDishes = allDishes.filter {$0.tegs.contains(.withFish)}
        }
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getFoodDishes)
            case .success(let dishes):
                VStack {
                    ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(Teg.allCases) { teg in
                                    DishTegView(isActive: teg == selectedIndex, text: teg.rawValue)
                                        .onTapGesture {
                                        selectedIndex = teg
                                    }
                                }
                            }
                        }
                        LazyVGrid(columns: columns, spacing: 45) {
                            ForEach(dishesArray, id: \.id) { item in
                                Button {
                                    withAnimation {
                                        popupDishData.selectedDish = item
                                        popupDishData.showPopup.toggle()
                                    }
                                } label: {
                                    DishView(dish: item)
                                        .matchedGeometryEffect(id: item.id, in: animation)
                                }
                            }
                        }
                        .onChange(of: selectedIndex, perform: performSort)
                        .padding()
                        .padding(.bottom, 8)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {

                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("back").frame(width: 6, height: 12)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {

                        Button {
                            //
                        } label: {
                            Image("photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipped()
                                .padding(.bottom, 8)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(categoryName)
                .overlay {
                    if popupDishData.showPopup {
                        ZStack {
                            PopupDishView(animation: animation)
                        }                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.black
                                .opacity(0.4)
                                .ignoresSafeArea())
                    }
                }
                .environmentObject(popupDishData)
            }
        }.onAppear(perform: viewModel.getFoodDishes)
    }
}

struct DetailDishesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct DishTegView: View {
    
    let isActive: Bool
    let text: String
    var body: some View {
        HStack(spacing: 0) {

            Text(text)
                .font(Font.custom("SF Pro Display", size: 13))
                .kerning(0.14)
                .foregroundColor( isActive ? Color.white : Color.black)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background( isActive ? Color("primary") : Color.black.opacity(0.07))
                .cornerRadius(10)
        }
        .padding(.leading)
        .padding(.top, 17)
    }
}
