//
//  LandingPage.swift
//  FoodOrderingApp
//
//  Created by Михаил on 06.07.2023.
//

import SwiftUI

struct LandingPage: View {
    
    @StateObject var viewModel = CategoryViewModelImpl(service: CategoriesServiceImpl())
    
    @State private var path = NavigationPath()

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getFoodCategory)
            case .success(let categories):
                ZStack {
                    HStack {
                        Image("location")
                            .frame(width: 24, height: 24)
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Санкт-Петербург")
                                .font(Font.custom("SF Pro Display", size: 18)
                                    .weight(.medium))
                            Text("12 Августа, 2023")
                                .font(Font.custom("SF Pro Display", size: 14))
                                .kerning(0.14)
                                .foregroundColor(.black.opacity(0.5))
                        }

                        Spacer()

                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .clipped()
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    
                    NavigationStack(path: $path) {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 15) {
                                ForEach(categories) { item in
                                    NavigationLink {
                                        DetailDishesView(path: $path, categoryName: item.name)
                                    } label: {
                                        CategoryView(category: item)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 65)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .background(Color.black.opacity(0.03).ignoresSafeArea())
            }
            
        }.onAppear(perform: viewModel.getFoodCategory)
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
