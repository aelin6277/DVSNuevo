//
//  DVSNuevoApp.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-06-27.
//

import SwiftUI

@main
struct DVSNuevoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

