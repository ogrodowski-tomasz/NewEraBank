//
//  ExpensesViewModel.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import Combine
import Foundation

class ExpensesViewModel:ObservableObject {
    
    @Published var expenses = [Expense]() {
        didSet {
            calculateOverall()
        }
    }
    @Published var walletValue = 0.0
    
    let expensesDataService = ExpensesDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    var todaysEarnings: Double {
        todaysBalance(forCategory: .income)
    }
    
    var todaysSpendings: Double {
        todaysBalance(forCategory: .expense)
    }
    
    func todaysBalance(forCategory category: ExpenseCategory) -> Double {
        var sum = 0.0
        expenses.forEach { expense in
            if Calendar.current.isDateInToday(expense.date) && expense.category == category {
                sum += expense.value
            }
        }
        return sum
    }
    
    private func addSubscribers() {
        expensesDataService.subject
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Subject published and failed ompletion with error: \(String(describing: error))")
                }
            } receiveValue: { [weak self] entities in
                var expenses = [Expense]()
                for entity in entities {
                    expenses.append(Expense(id: entity.id ?? UUID(), name: entity.name ?? "", date: entity.date ?? Date(), value: entity.value, category: entity.isIncome ? .income : .expense))
                }
                DispatchQueue.main.async {
                    self?.expenses = expenses
                }
            }
            .store(in: &cancellables)
    }
    
    func addExpense(_ expense: Expense) {
        expensesDataService.add(expense: expense)
    }
    
    func calculateOverall() {
        var calculatedValue = 0.0
        for expense in expenses {
            if expense.category == .income {
                calculatedValue += expense.value
            } else {
                calculatedValue -= expense.value
            }
        }
        walletValue = calculatedValue
    }
    
    func deleteExpense(_ expense: Expense) {
        guard let entity = expensesDataService.subject.value.first(where: { $0.id == expense.id })  else { return }
        expensesDataService.delete(entity: entity)
    }
    
}
