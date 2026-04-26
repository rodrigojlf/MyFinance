//
//  UserManager.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 25/04/26.
//

// UserManager.swift
import Foundation
import Observation

@Observable
final class UserManager {
    var currentUser: User?
    
    func clearSession() {
        currentUser = nil
    }
}
