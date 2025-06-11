//
//  CellView.swift
//  PuzzleVault
//
//  Created by Valentyn Kotenko on 11/6/25.
//

import SwiftUI

struct CellView: View {
    let value: Int
    let size: CGFloat = 36
    let isFixed: Bool
    
    var displayText: String {
        value == 0 ? "" : "\(value)"
    }
    
    var body: some View {
        Text(displayText)
            .frame(width: size, height: size)
            .background(isFixed ? Color.gray.opacity(0.4) : Color.white)
            .border(Color.black, width: 0.5)
            .font(.body.bold())
            .foregroundColor(isFixed ? .black : .white)
    }
}

#Preview {
    CellView(value: 3, isFixed: false)
}
