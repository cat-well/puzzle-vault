//
//  SudokuGameView.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI
import CoreData

struct SudokuGameView: View {
    @Environment(\.coreDataContext) private var viewContext: NSManagedObjectContext
    @StateObject private var vm = SudokuGameViewModel(viewContext: PersistenceController.shared.container.viewContext)
    
    @State private var selectedCell: (row: Int, col: Int)?
    @State private var selectedLevel: SudokuGrid.Level = .easy
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 1), count: 9)

    var body: some View {
        content
            .navigationTitle("Sudoku")
            .onAppear { vm.newGame(level: selectedLevel) }
            .alert(isPresented: $vm.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(vm.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }

    private var content: some View {
        VStack(spacing: 16) {
            headerView
            gridView
            padView
            footerView
        }
        .padding()
    }

    private var headerView: some View {
        HStack {
            Picker("Difficulty", selection: $selectedLevel) {
                Text("Easy").tag(SudokuGrid.Level.easy)
                Text("Medium").tag(SudokuGrid.Level.medium)
                Text("Hard").tag(SudokuGrid.Level.hard)
            }
            .pickerStyle(SegmentedPickerStyle())

            Button(action: { vm.newGame(level: selectedLevel) }) {
                Text("New Game")
            }
            .padding(.leading)
        }
    }

    private var gridView: some View {
        
        return LazyVGrid(columns: columns, spacing: 1) {
            ForEach(0..<81, id: \.self) { index in
                let row = index / 9
                let col = index % 9
                cellView(row: row, col: col)
                    .onTapGesture { selectedCell = (row, col) }
            }
        }
        .background(Color.gray.opacity(0.2))
    }
    
    private func rowView(_ row: Int) -> some View {
        ForEach(0..<9, id: \.self) { col in
            cellView(row: row, col: col)
            .onTapGesture { selectedCell = (row, col) }
        }
    }
    
    private func cellView(row: Int, col: Int) -> some View {
        let value = vm.grid.cells[row][col]
        
        return CellView(
            value: value,
            isFixed: value != 0
        )
        .frame(minWidth: 32, minHeight: 32)
    }

    @ViewBuilder
    private var padView: some View {
        if let cell = selectedCell {
            NumberPadView(
                onSelect: { num in
                    vm.grid.cells[cell.row][cell.col] = num
                    selectedCell = nil
                },
                onClear: {
                    vm.grid.cells[cell.row][cell.col] = 0
                    selectedCell = nil
                }
            )
            .transition(.move(edge: .bottom))
        }
    }

    private var footerView: some View {
        HStack(spacing: 24) {
            Button(action: vm.validate) {
                Text("Check")
            }
            Button(action: vm.saveProgress) {
                Text("Save")
            }
        }
    }
}

#Preview {
    SudokuGameView()
}
