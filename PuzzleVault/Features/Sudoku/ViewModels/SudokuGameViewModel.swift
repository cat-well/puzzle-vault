//
//  SudokuGameViewModel.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import Foundation
import CoreData

class SudokuGameViewModel: ObservableObject {
    @Published var grid: SudokuGrid
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.grid = SudokuGrid()
        self.viewContext = viewContext
    }
    
    func newGame(level: SudokuGrid.Level = .easy) {
        grid.generate(level: level)
    }
    
    func validate() {
        if grid.isValid() {
            showError = false
        } else {
            showError = true
            errorMessage = "Wrong answer"
        }
    }
    
    func saveProgress() {
        let state = GameState(context: viewContext)
        state.id = UUID()
        state.puzzleType = "sudoku"
        state.timestamp = Date()
        do {
            let cellsData = try JSONEncoder().encode(grid.cells)
            state.data = cellsData
            
            try viewContext.save()
        } catch {
            print("Error saving game state: ", error)
        }
    }
    
    func loadProgress() {
        let request: NSFetchRequest<GameState> = GameState.fetchRequest()
        request.predicate = NSPredicate(format: "puzzleType == %@", "sudoku")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        request.fetchLimit = 1
        
        do {
            if let state = try viewContext.fetch(request).first {
                let cells = try JSONDecoder().decode([[Int]].self, from: state.data)
                grid.cells = cells
            }
        } catch {
            print("Error loading game state: ", error)
        }
    }
}
