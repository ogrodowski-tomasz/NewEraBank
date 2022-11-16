//
//  AddExpenseView.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var viewModel: ExpensesViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var expenseName = ""
    @State private var value = ""
    @State private var category: ExpenseCategory = .expense
    
    @State private var errorMessage: String? = nil
    
    var body: some View {
        Form {
            TextField("Name", text: $expenseName, prompt: Text("Expense description"))
            TextField("Value", text: $value, prompt: Text("$0.00"))
                .keyboardType(.decimalPad)
            Picker("Type", selection: $category) {
                ForEach(ExpenseCategory.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Section {
                Button {
                    addExpense {
                        dismiss()
                    }
                } label: {
                    Text("Submit")
                        .foregroundColor(.black.opacity(submitButtonDisabled ? 0.4 : 1.0))
                        .fontWeight(.semibold)
                }
                .disabled(submitButtonDisabled)
            } footer: {
                if let errorMessage {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                        Text("Error: ").bold()
                        +
                        Text(errorMessage)
                    }
                    .foregroundColor(.red)
                }
            }
            
        }
        .foregroundColor(.theme.label)
        .scrollContentBackground(.hidden)
        .background { Color.theme.background.ignoresSafeArea() }
    }
    
    func addExpense(completion: () -> Void) {
        guard let value = Double(value) else {
            errorMessage = "Incorrect value data"
            return
        }
        let expense = Expense(id: UUID(), name: expenseName, date: Date(), value: value, category: category)
        viewModel.addExpense(expense)
        completion()
    }
    
    var submitButtonDisabled: Bool {
        return expenseName.isEmpty || value.isEmpty
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(viewModel: ExpensesViewModel())
    }
}
