//
//  User.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 04/04/26.
//

import Foundation

struct User: Codable {
    let uid: String
    let name: String
    var email: String
    var photoUrl: String
    var budgets: [Budget]
}

