//
//  HomeView.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {

        TabView {
            NavigationStack {
                LandingPage()
            }
            .tag("Главная")
            .tabItem {
                VStack {
                    Image("home").renderingMode(.template)
                    Text("Главная")
                        .font(
                            Font.custom("SF Pro Display", size: 10)
                            .weight(.medium))
                }
            }
            Text("Поиск")
                .tag("Поиск")
                .tabItem {
                    VStack {
                        Image("search").renderingMode(.template)
                        Text("Поиск")
                            .font(
                                Font.custom("SF Pro Display", size: 10)
                                .weight(.medium))
                    }
                }
            
            
            NavigationStack {
                CartView()
            }
            .tag("Корзина")
            .tabItem {
                VStack {
                    Image("order").renderingMode(.template)
                    Text("Корзина")
                        .font(
                            Font.custom("SF Pro Display", size: 10)
                            .weight(.medium))
                }
            }
            Text("Аккаунт")
                .tag("Аккаунт")
                .tabItem {
                    VStack {
                        Image("account").renderingMode(.template)
                        Text("Аккаунт")
                            .font(
                                Font.custom("SF Pro Display", size: 10)
                                .weight(.medium))
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CartViewModel())
    }
}
