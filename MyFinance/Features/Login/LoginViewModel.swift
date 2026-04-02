//
//  LoginViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import Foundation

final class LoginViewModel {
    var onLoginSuccess: (() -> Void)?
    
    func performLogin() {
        // TO DO - lógica de validação de email/senha ou requisição à API.
        onLoginSuccess?()
    }
}
