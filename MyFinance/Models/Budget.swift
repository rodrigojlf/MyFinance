//
//  Budget.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import Foundation

struct Budget {
    let id: String
    let monthYear: String // "00/0000"
    let limitAmount: Double
    var transactions: [Transaction]
    var amountSpent: Double { transactions.reduce(0) { $0 + $1.amount } }
    var balance: Double { limitAmount - amountSpent }
    
    var wrappedMonth: String { monthYear.monthName ?? "" }
    var wrappedYear: String {
        var result = ""
        result.append(contentsOf: monthYear.split(separator: "/").last ?? "")
        return result
    }
}
