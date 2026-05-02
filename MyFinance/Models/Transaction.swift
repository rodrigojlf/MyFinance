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

extension TransactionIcon {
    var description: String {
        switch self {
        case .basket:
            return "Mercado"
        case .gift:
            return "Presente"
        case .note:
            return "Contas"
        case .home:
            return "Casa"
        case .briefcase:
            return "Trabalho"
        }
    }
}

struct Transaction: Codable {
    let id: String
    let title: String
    let date: String
    let amount: Double
    let type: TransactionType
    let iconName: TransactionIcon // É o valor digitado em Categoria - textfield
}
