//
//  LoginViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    
    var nameText: String = "" { didSet { validateForm() } }
    var emailText: String = "" { didSet { validateForm() } }
    var passwordText: String = "" { didSet { validateForm() } }
    
    var onNameErrorChanged: ((Bool) -> Void)?
    var onEmailErrorChanged: ((Bool) -> Void)?
    var onPasswordErrorChanged: ((Bool) -> Void)?
    var onLoginButtonStateChanged: ((Bool) -> Void)?
    
    var onLoginSuccess: (() -> Void)?
    var onLoginError: ((String) -> Void)?
    
    private let authService: AuthServiceProtocol
    private let userManager: UserManager
    
    init(authService: AuthServiceProtocol = AuthenticationService(), userManager: UserManager) {
        self.authService = authService
        self.userManager = userManager
    }
    
    private func validateForm() {
        let isNameValid = nameText.count >= 2
        let isEmailValid = isValidEmail(emailText)
        let isPasswordValid = passwordText.count >= 6
        
        onNameErrorChanged?(!nameText.isEmpty && !isNameValid)
        onEmailErrorChanged?(!emailText.isEmpty && !isEmailValid)
        onPasswordErrorChanged?(!passwordText.isEmpty && !isPasswordValid)
        
        let isFormValid = isNameValid && isEmailValid && isPasswordValid
        onLoginButtonStateChanged?(isFormValid)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func performLogin() {
        Task {
            do {
                try await authService.login(email: emailText, password: passwordText)
                
                // SIMULAÇÃO: Populando o usuário após o sucesso
                // Quando tiver o Firebase, você extrai essas infos do Firebase Auth / Firestore
                let loggedInUser = Mock.user
                
                await MainActor.run {
                    self.userManager.currentUser = loggedInUser // Virá do Firebase
                    onLoginSuccess?()
                }
            } catch {
                await MainActor.run {
                    onLoginError?(error.localizedDescription)
                }
            }
        }
    }
}
