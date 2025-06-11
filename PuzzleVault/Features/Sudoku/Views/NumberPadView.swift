//
//  NumberPadView.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI

struct NumberPadView: View {
    let onSelect: (Int) -> Void
    let onClear: () -> Void
    
    private let numbers = Array(1...9)
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(numbers, id: \.self) { num in
                Button(action: { onSelect(num) }) {
                    Text("\(num)")
                        .frame(minWidth: 44, minHeight: 44)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Button(action: onClear) {
                Text("Clear")
                    .frame(minWidth: 44, minHeight: 44)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

//#Preview {
//    NumberPadView()
//}
