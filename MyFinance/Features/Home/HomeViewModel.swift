//
//  HomeViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

final class HomeViewModel {
    
    var onDataUpdated: (() -> Void)?
    var onAddTransactionRequested: (() -> Void)?
    
    private(set) var transactions: [Transaction] = []
    
    let userName = "Jonas"
    let availableAmount = "R$ 1.256,98"
    let usedAmount = "R$ 2.943,02"
    let limitAmount = "R$ 4.200,00"
    let budgetProgress: Float = 0.7
    
    func loadData() {
        self.transactions = [
            Transaction(id: "1", title: "Mercado", date: "02/05/25", amount: 450.67, type: .expense, iconName: "basket"),
            Transaction(id: "2", title: "Presente de aniversário", date: "04/05/25", amount: 89.90, type: .expense, iconName: "gift"),
            Transaction(id: "3", title: "Conta de energia", date: "05/05/25", amount: 245.72, type: .expense, iconName: "note"),
            Transaction(id: "4", title: "Aluguel", date: "05/05/25", amount: 2240.00, type: .expense, iconName: "home"),
            Transaction(id: "5", title: "Salário", date: "05/05/25", amount: 5000.00, type: .income, iconName: "briefcase")
        ]
        
        self.onDataUpdated?()
    }
    
    func didTapAddTransaction() {
        onAddTransactionRequested?()
    }
    
    var onSettingsRequested: (() -> Void)?
        func didTapSettings() { onSettingsRequested?() }
}
