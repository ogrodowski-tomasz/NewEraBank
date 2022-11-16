//
//  Expense.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import Foundation

struct Expense: Identifiable {
    let id: UUID
    let name: String
    let date: Date
    let value: Double
    let category: ExpenseCategory
}

enum ExpenseCategory: CaseIterable {
    case income
    case expense
    
    var description: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
