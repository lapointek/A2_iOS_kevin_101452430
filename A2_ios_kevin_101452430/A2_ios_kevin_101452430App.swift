//
//  A2_ios_kevin_101452430App.swift
//  A2_ios_kevin_101452430
//
//  Created by Kevin Lapointe on 2025-03-27.
//

import SwiftUI

@main
struct A2_ios_kevin_101452430App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
