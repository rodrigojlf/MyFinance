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
    var onSaveSuccess:((Bool, String?) -> Void)?
    
    private let userManager: UserManager
    
    var budgets: [Budget] {
        userManager.currentUser?.budgets ?? []
    }
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
//    func loadData() {
//        onDataUpdated?()
//    }
    
    func addBudget(monthYear: String, amount: String) {
        if !monthYear.isEmpty && !amount.isEmpty {
            userManager.addBudget(monthYear: monthYear, limitAmount: Double(amount) ?? 0.0)
            onSaveSuccess?(true, nil)
            onDataUpdated?()
        } else {
            onSaveSuccess?(false, "Preecha todos os campos.")
        }
    }
    
    func removeBudget(at index: Int) {
//        budgets.remove(at: index)
        onDataUpdated?()
    }
    
    func goBack() {
        onBackRequested?()
    }
}
