//
//  PuzzleVaultApp.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI
import CoreData

@main
struct PuzzleVaultApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(\.coreDataContext, persistenceController.container.viewContext)
        }
    }
}
