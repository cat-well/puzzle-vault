//
//  MenuView.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.coreDataContext) private var viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SudokuGameView()) {
                    Text("Sudoku")
                }
                // Future puzzles
                // NavigationLink(destination: OtherPuzzleView()) { Text("Other Puzzle") }
            }
            .navigationTitle("Puzzle Vault")
        }
    }
}

private struct CoreDataContextKey: EnvironmentKey {
    static let defaultValue: NSManagedObjectContext = PersistenceController.shared.container.viewContext
}

extension EnvironmentValues {
    var coreDataContext: NSManagedObjectContext {
        get { self[CoreDataContextKey.self] }
        set { self[CoreDataContextKey.self] = newValue }
    }
}

#Preview {
    MenuView()
}
