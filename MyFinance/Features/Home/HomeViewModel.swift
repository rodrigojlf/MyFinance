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
    var onLogoutSuccess: (() -> Void)?
    var onLogoutFailure: ((String) -> Void)?
    
    private let authService: AuthServiceProtocol
    private let userManager: UserManager
    
    private var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var selectedMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1 {
        didSet {
            filterDataByMonth()
        }
    }
    
    var filteredTransactions: [Transaction] = []
    var currentBudget: Budget?
    var currentMonthYear: String = ""
    var user: User? { userManager.currentUser }
    
    init(authService: AuthServiceProtocol = AuthenticationService(), userManager: UserManager) {
        self.authService = authService
        self.userManager = userManager
        filterDataByMonth()
    }
    
    func logout() {
        do {
            try authService.logout()
            onLogoutSuccess?()
        } catch {
            onLogoutFailure?(error.localizedDescription)
        }
    }
    
    func loadData() {
        
        self.onDataUpdated?()
    }
    
    func didTapAddTransaction() {
        onAddTransactionRequested?()
    }
    
    var onSettingsRequested: (() -> Void)?
    func didTapSettings() { onSettingsRequested?() }
    
    private func filterDataByMonth() {
        guard let user = userManager.currentUser else {
            filteredTransactions = []
            currentBudget = nil
            return
        }
        
        let formattedMonthYear = String(format: "%02d/%04d", selectedMonthIndex + 1, currentYear)
        currentMonthYear = formattedMonthYear
        
        if let budget = user.budgets.first(where: { $0.monthYear == formattedMonthYear }) {
            self.currentBudget = budget
            self.filteredTransactions = budget.transactions
        } else {
            self.currentBudget = nil
            self.filteredTransactions = []
        }
    }
}
