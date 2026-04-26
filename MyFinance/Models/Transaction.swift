//
//  Transaction.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

// Transaction.swift
import Foundation

enum TransactionType: Codable {
    case income
    case expense
}

enum TransactionIcon: String, Codable {
    case basket
    case gift
    case note
    case home
    case briefcase
}

struct Transaction: Codable {
    let id: String
    let title: String
    let date: String
    let amount: Double
    let type: TransactionType
    let iconName: TransactionIcon // É o valor digitado em Categoria - textfield
}
