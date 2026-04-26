//
//  Budget.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

struct Budget: Codable {
    let id: String
    let monthYear: String // "00/0000"
    let limitAmount: Double
    var transactions: [Transaction]
    var amountSpent: Double {
        transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    var balance: Double { limitAmount - amountSpent }
}
