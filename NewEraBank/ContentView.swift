//
//  ContentView.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAddExpense = false
    @StateObject private var viewModel = ExpensesViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    CustomNavigationBar()
                    .sheet(isPresented: $showAddExpense, content: {
                        AddExpenseView(viewModel: viewModel)
                    })
                    
                    
                    HStack {
                        Spacer()
                        DebitCardView(viewModel: viewModel)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 50)
                    
                    VStack(alignment: .leading) {
                        Text("Recent Transactions")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        ForEach(viewModel.expenses.reversed()) { expense in
                            ExpensionRow(expense: expense)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteExpense(expense)
                                    } label: {
                                        Text("Delete")
                                    }
                                }
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
            }
        }
        .foregroundColor(.theme.label)
    }
    
    private func CustomNavigationBar() -> some View {
        HStack {
            Spacer()
            Button {
                showAddExpense.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20)
            }
        }
        .padding(.horizontal, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
