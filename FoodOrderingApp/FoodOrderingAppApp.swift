//
//  FoodOrderingAppApp.swift
//  FoodOrderingApp
//
//  Created by Михаил on 30.06.2023.
//

import SwiftUI

@main
struct FoodOrderingAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var cartData = CartViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cartData)
        }
    }
}
