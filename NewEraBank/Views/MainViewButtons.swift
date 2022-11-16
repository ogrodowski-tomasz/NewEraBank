//
//  MainViewButtons.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

enum MainViewButtons: CaseIterable {
    case incomes
    case outcome
    case saldo
    case all
    
    var imageName: String {
        switch self {
        case .incomes:
            return "square.and.arrow.up"
        case .outcome:
            return "square.and.arrow.down"
        case .saldo:
            return "arrow.up.arrow.down"
        case .all:
            return "square.grid.2x2"
        }
    }
}

struct ButtonView: View {
    var imageName: String
    let size = 25.0
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
        }
        .foregroundColor(.theme.label)
    }
}
