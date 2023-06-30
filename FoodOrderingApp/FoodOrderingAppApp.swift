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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
