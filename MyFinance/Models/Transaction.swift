//
//  Transaction.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

// Transaction.swift
import Foundation

enum TransactionType {
    case income
    case expense
}

struct Transaction {
    let id: String
    let title: String
    let date: String
    let amount: Double
    let type: TransactionType
    let iconName: String // É o valor digitado em Categoria - textfield
}
