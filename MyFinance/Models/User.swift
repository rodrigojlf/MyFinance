//
//  User.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 04/04/26.
//

import Foundation

struct User {
    let name: String
    var photoUrl: String
    var accountLimit: Double
    var transactions: [Transaction]
    var amountSpent: Double { transactions.reduce(0) { $0 + $1.amount } }
    var accountBalance: Double { accountLimit - amountSpent }
}
