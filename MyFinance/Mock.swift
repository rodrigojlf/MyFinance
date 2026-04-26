//
//  Mock.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 25/04/26.
//

import Foundation

final class Mock {
    
    static var user = User(uid: UUID().uuidString,
                           name: "João",
                           email: "teste@email.com",
                           photoUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                           budgets: budgets)
    
    static private var budgets: [Budget] = [
        Budget(id: UUID().uuidString,
               monthYear: "01/2026",
               limitAmount: 8000,
               transactions: janTransactions),
        Budget(id: UUID().uuidString,
               monthYear: "02/2026",
               limitAmount: 9000,
               transactions: fevTransactions),
        Budget(id: UUID().uuidString,
               monthYear: "04/2026",
               limitAmount: 5000,
               transactions: abrTransactions),
    ]
    
    static private var janTransactions: [Transaction] = [
        Transaction(id: UUID().uuidString,
                    title: "Mercado",
                    date: "08/01/26",
                    amount: 450.67,
                    type: .expense,
                    iconName: .basket),
        Transaction(id: UUID().uuidString,
                    title: "Presente de aniversário",
                    date: "06/01/26",
                    amount: 89.9,
                    type: .expense,
                    iconName: .gift),
        Transaction(id: UUID().uuidString,
                    title: "Conta de energia",
                    date: "02/01/26",
                    amount: 243.72,
                    type: .expense,
                    iconName: .note),
        Transaction(id: UUID().uuidString,
                    title: "Aluguel",
                    date: "02/01/26",
                    amount: 2240,
                    type: .expense,
                    iconName: .home),
        Transaction(id: UUID().uuidString,
                    title: "Salário",
                    date: "02/01/26",
                    amount: 5000,
                    type: .income,
                    iconName: .briefcase)
    ]
    
    static private var fevTransactions: [Transaction] = [
        Transaction(id: UUID().uuidString,
                    title: "Mercado",
                    date: "08/02/26",
                    amount: 450.67,
                    type: .expense,
                    iconName: .basket),
        Transaction(id: UUID().uuidString,
                    title: "Presente de aniversário",
                    date: "06/02/26",
                    amount: 89.9,
                    type: .expense,
                    iconName: .gift),
        Transaction(id: UUID().uuidString,
                    title: "Conta de energia",
                    date: "02/02/26",
                    amount: 243.72,
                    type: .expense,
                    iconName: .note),
        Transaction(id: UUID().uuidString,
                    title: "Aluguel",
                    date: "02/02/26",
                    amount: 2240,
                    type: .expense,
                    iconName: .home),
        Transaction(id: UUID().uuidString,
                    title: "Salário",
                    date: "02/02/26",
                    amount: 5000,
                    type: .income,
                    iconName: .briefcase)
    ]
    
    static private var abrTransactions: [Transaction] = [
        Transaction(id: UUID().uuidString,
                    title: "Aluguel",
                    date: "02/04/26",
                    amount: 2240,
                    type: .expense,
                    iconName: .home),
        Transaction(id: UUID().uuidString,
                    title: "Mercado",
                    date: "08/04/26",
                    amount: 382.94,
                    type: .expense,
                    iconName: .basket),
        Transaction(id: UUID().uuidString,
                    title: "Conta de energia",
                    date: "02/04/26",
                    amount: 243.72,
                    type: .expense,
                    iconName: .note),
        Transaction(id: UUID().uuidString,
                    title: "Presente",
                    date: "27/04/26",
                    amount: 91.37,
                    type: .expense,
                    iconName: .gift),
        Transaction(id: UUID().uuidString,
                    title: "Salário",
                    date: "02/04/26",
                    amount: 5000,
                    type: .income,
                    iconName: .briefcase)
    ]
}
