//
//  BudgetSettingsViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

final class BudgetSettingsViewModel {
    var onDataUpdated: (() -> Void)?
    var onBackRequested: (() -> Void)?
    
    private(set) var budgets: [Budget] = []
    
    func loadData() {
        budgets = [
            Budget(id: "1", monthYear: "03/2026", limitAmount: 7000.00, transactions: []),
            Budget(id: "2", monthYear: "04/2026", limitAmount: 8000.00, transactions: []),
            Budget(id: "3", monthYear: "05/2026", limitAmount: 5000.00, transactions: []),
            Budget(id: "4", monthYear: "06/2026", limitAmount: 9000.00, transactions: []),
        ]
        onDataUpdated?()
    }
    
    func addBudget(monthYear: String?, amount: String?) {
        guard let month = monthYear, !month.isEmpty,
              let amountStr = amount, let value = Double(amountStr.replacingOccurrences(of: ",", with: ".")) else { return }
        
        let newBudget = Budget(id: UUID().uuidString, monthYear: month, limitAmount: value, transactions: [])
        budgets.insert(newBudget, at: 0)
        onDataUpdated?()
    }
    
    func removeBudget(at index: Int) {
        budgets.remove(at: index)
        onDataUpdated?()
    }
    
    func goBack() {
        onBackRequested?()
    }
}
