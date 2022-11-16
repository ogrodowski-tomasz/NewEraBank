//
//  DebitCardView.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

struct DebitCardView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .center, spacing: 30) {
                Text("Balance")
                    .font(.headline)
                Text("$ \(viewModel.walletValue.abbreviated())")
                    .font(.largeTitle)
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
            .backgroundStyle(.ultraThinMaterial)
            
            ZStack(alignment: .leading) {
                Rectangle().fill(Color.theme.lightPurple)
                    .frame(height: 65)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Today you spent: ") + Text("$\(viewModel.todaysSpendings.abbreviated())").bold().foregroundColor(.red.opacity(0.6 ))
                    Text("Today you earned: ") + Text("$\(viewModel.todaysEarnings.abbreviated())").bold().foregroundColor(.theme.lightGreen)
                }
                .padding(.leading)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 25)
                .strokeBorder(Color.theme.lightPurple, lineWidth: 5)
        }
        .cornerRadius(25)
    }
}
