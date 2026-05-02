//
//  AddTransactionViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

final class AddTransactionViewModel {
    
    let userManager: UserManager
    var onSaveSuccess: ((Bool) -> Void)?
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func saveTransaction(title: String?, category: TransactionIcon?, date: String?, amount: String?, type: TransactionType?) {
        
        guard let title = title, !title.isEmpty,
              let date = date, !date.isEmpty,
              let amountString = amount,
              let type = type,
              let iconName = category else {
            print("Erro: Todos os campos são obrigatórios.")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .decimal

        guard let number = formatter.number(from: amountString) else {
            print("Erro: Valor da transação inválido. String recebida: \(amountString)")
            return
        }

        let amountValue = number.doubleValue
        
        let newTransaction = Transaction(
            id: UUID().uuidString,
            title: title,
            date: date,
            amount: amountValue,
            type: type,
            iconName: iconName
        )
        
        let dateComponents = date.split(separator: "/")
        guard dateComponents.count >= 2 else {
            print("Erro: Formato de data inválido. Esperado dd/MM/yyyy.")
            return
        }
        
        let monthYear = "\(dateComponents[1])/\(dateComponents[dateComponents.count - 1])"
        
        let result = userManager.addTransaction(newTransaction, toMonthYear: monthYear)
        onSaveSuccess?(result)
        
    }
}
