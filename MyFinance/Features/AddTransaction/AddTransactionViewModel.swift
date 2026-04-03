//
//  AddTransactionViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

final class AddTransactionViewModel {
    var onSaveSuccess: (() -> Void)?
    
    private var transactionType: TransactionType = .expense
    
    func updateType(_ type: TransactionType) {
        self.transactionType = type
    }
    
    func saveTransaction(title: String?, category: String?, amount: String?, date: String?) {
        guard let title = title, !title.isEmpty,
              let amount = amount, !amount.isEmpty else {
            print("Erro: Campos obrigatórios vazios")
            return
        }
        
        print("Salvando: \(title) de \(amount) como \(transactionType)")
        
        onSaveSuccess?()
    }
}
