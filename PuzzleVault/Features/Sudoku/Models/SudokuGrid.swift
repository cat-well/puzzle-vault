//
//  SudokuGrid.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import Foundation

struct SudokuGrid {
    public var cells: [[Int]]
    enum Level { case easy, medium, hard }
    
    init() {
        self.cells = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    }
    
    // MARK: - Public Methods
    
    public mutating func generate(level: Level) {
        cells = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        
        for start in stride(from: 0, to: 9, by: 3) {
            fillBox(row: start, col: start)
        }
        
        _ = fillRemaining(row: 0, col: 3)
        
        removeCells(level: level)
    }
    
    public func isValid() -> Bool {
        for i in 0..<9 {
            if !isUniqueArray(cells[i]) { return false }
            let col = (0..<9).map { cells[$0][i] }
            if !isUniqueArray(col) { return false }
        }
        for row in stride(from: 0, to: 9, by: 3) {
            for col in stride(from: 0, to: 9, by: 3) {
                if !checkBox(rowStart: row, colStart: col) { return false }
            }
        }
        
        return true
    }
    
    // MARK: - Helpers
    
    private func isUniqueArray(_ arr: [Int]) -> Bool {
        let nums = arr.filter { $0 != 0 }
        
        return Set(nums).count == nums.count && nums.count == 9
    }
    
    private func checkBox(rowStart: Int, colStart: Int) -> Bool {
        var seen = Set<Int>()
        for r in 0..<3 {
            for c in 0..<3 {
                let val = cells[rowStart + r][colStart + c]
                if val == 0 { return false }
                if seen.contains(val) { return false }
                seen.insert(val)
            }
        }
        
        return true
    }
    
    private mutating func fillBox(row: Int, col: Int) {
        var nums = Array(1...9).shuffled()
        for r in 0..<3 {
            for c in 0..<3 {
                cells[row + r][col + c] = nums.removeFirst()
            }
        }
    }
    
    private func isSafe(row: Int, col: Int, num: Int) -> Bool {
        for x in 0..<9 {
            if cells[row][x] == num || cells[x][col] == num { return false }
        }
        
        let boxRow = row - row % 3
        let boxCol = col - col % 3
        for r in 0..<3 {
            for c in 0..<3 {
                if cells[boxRow + r][boxCol + c] == num { return false }
            }
        }
        
        return true
    }
    
    // Recursive fill
    @discardableResult
    private mutating func fillRemaining(row: Int, col: Int) -> Bool {
        var row = row, col = col
        
        if col >= 9 && row < 8 {
            row += 1
            col = 0
        }
        if row >= 9 && col >= 9 { return true }
        
        if row < 3 {
            if col < 3 { col = 3 }
        } else if row < 6 {
            if col == Int(row / 3) * 3 { col += 3 }
        } else {
            if col == 6 {
                row += 1; col = 0
                if row >= 9 { return true }
            }
        }
        
        for num in (1...9).shuffled() {
            if isSafe(row: row, col: col, num: num) {
                cells[row][col] = num
                if fillRemaining(row: row, col: col + 1) { return true }
                cells[row][col] = 0
            }
        }
        
        return false
    }
    
    private mutating func removeCells(level: Level) {
        let attempts: Int
        switch level {
            case .easy:
                attempts = 30
            case .medium:
                attempts = 40
            case .hard:
                attempts = 50
        }
        
        var count = attempts
        while count > 0 {
            let i = Int.random(in: 0..<9)
            let j = Int.random(in: 0..<9)
            if cells[i][j] != 0 {
                let backup = cells[i][j]
                cells[i][j] = 0
                // Optionaly check unique solution: omitted for MVP
                count -= 1
            }
        }
    }
    
}
