//
//  ExpensionRow.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

struct ExpensionRow: View {
    
    let expense: Expense
    
    var color: Color {
        expense.category == .income ? .theme.lightGreen : .red
    }
    
    var symbolImageName: String {
        expense.category == .income ? "arrow.down" : "arrow.up"
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                Circle()
                    .stroke(color, lineWidth: 2)
                Image(systemName: symbolImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
            }
            .frame(width: 50)
            
            Text(expense.name)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text("$\(expense.value.abbreviated())")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.trailing)
                .shadow(color: color, radius: 1, x: 1, y: 1)
        }
        .frame(maxWidth: .infinity)
        .background { Color.theme.background.opacity(0.001) }
    }
}
