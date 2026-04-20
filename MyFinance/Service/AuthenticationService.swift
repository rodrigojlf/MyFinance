//
//  AuthenticationService.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 20/04/26.
//

import Foundation
import FirebaseAuth

// Protocolo para facilitar a Injeção de Dependência e Testes
protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
    func logout() throws
    func hasActiveSession() -> Bool
}

class AuthenticationService: AuthServiceProtocol {
    
    func login(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func hasActiveSession() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
