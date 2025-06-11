//
//  PuzzleVaultApp.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI

@main
struct PuzzleVaultApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
