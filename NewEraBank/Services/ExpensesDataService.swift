//
//  ExpensesDataService.swift
//  NewEraBank
//
//  Created by Tomasz Ogrodowski on 16/11/2022.
//

import Combine
import CoreData
import Foundation

protocol ExpensesDataServiceable {
    var subject: CurrentValueSubject<[ExpenseEntity], Error> { get }
}

class ExpensesDataService: ExpensesDataServiceable {
    private var container: NSPersistentContainer
    private var containerName: String = "ExpenseDataModel"
    private var entityName: String = "ExpenseEntity"
    
    var subject = CurrentValueSubject<[ExpenseEntity], Error>([])
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error {
                print("DEBUG: Error loading Core Data: \(String(describing: error))")
                self?.subject.send(completion: .failure(error))
            }
            self?.getExpensesData()
        }
    }
    
    
    private func getExpensesData() {
        let request = NSFetchRequest<ExpenseEntity>(entityName: entityName)
        do {
            let fetchedExpenses = try container.viewContext.fetch(request)
            
            subject.send(fetchedExpenses)
        } catch {
            subject.send(completion: .failure(error))
        }
    }
    
    func add(expense: Expense) {
        let entity = ExpenseEntity(context: container.viewContext)
        entity.name = expense.name
        entity.id = expense.id
        entity.isIncome = expense.category == .income
        entity.value = expense.value
        entity.date = expense.date
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving data")
        }
    }
    
    func delete(entity: ExpenseEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getExpensesData()
    }
}


extension ExpensesDataService {
    private func clearContainer(entities: [ExpenseEntity]) {
        for entity in entities {
            container.viewContext.delete(entity)
            applyChanges()
        }
    }
}
