//
//  UserManager.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 25/04/26.
//

// UserManager.swift
import Foundation
import Observation

@Observable
final class UserManager {
    var currentUser: User?
    
    func clearSession() {
        currentUser = nil
    }
    
    func addBudget(monthYear: String, limitAmount: Double) {
        let newBudget = Budget(id: UUID().uuidString, monthYear: monthYear, limitAmount: limitAmount, transactions: [])
        currentUser?.budgets.append(newBudget)
        // saveToFirebaseFirestore()
    }
    
    func addTransaction(_ transaction: Transaction, toMonthYear monthYear: String) -> Bool {
        guard let budgetIndex = currentUser?.budgets.firstIndex(where: { $0.monthYear == monthYear }) else {
            return false
        }
        
        currentUser?.budgets[budgetIndex].transactions.append(transaction)
        // saveToFirebaseFirestore()
        return true
    }
    
    func deleteTransaction(withId transactionId: String, fromMonthYear monthYear: String) {
        guard let budgetIndex = currentUser?.budgets.firstIndex(where: { $0.monthYear == monthYear }) else { return }
        
        currentUser?.budgets[budgetIndex].transactions.removeAll(where: { $0.id == transactionId })
        // saveToFirebaseFirestore()
    }
}
