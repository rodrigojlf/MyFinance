//
//  LoginViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel: LoginViewModel
    private let screen = LoginScreen()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.delegate(delegate: self)
        setupBindings()
        
        // Para facilitar os testes de login
        screen.injectLoginData()
    }
    
    private func setupBindings() {
        
        viewModel.onNameErrorChanged = { [weak self] hasError in
            self?.screen.setNameError(hasError)
        }
        
        viewModel.onEmailErrorChanged = { [weak self] hasError in
            self?.screen.setEmailError(hasError)
        }
        
        viewModel.onPasswordErrorChanged = { [weak self] hasError in
            self?.screen.setPasswordError(hasError)
        }
        
        viewModel.onLoginButtonStateChanged = { [weak self] isEnabled in
            self?.screen.setLoginButton(isEnabled: isEnabled)
        }
        
        viewModel.onLoginError = { [weak self] errorMessage in
            AlertManager.showAlert(on: self, title: "Erro de Login", message: errorMessage)
        }
    }
}

extension LoginViewController: LoginScreenProtocol {
    
    func nameDidChange(text: String) {
        viewModel.nameText = text
    }
    
    func emailDidChange(text: String) {
        viewModel.emailText = text
    }
    
    func passwordDidChange(text: String) {
        viewModel.passwordText = text
    }
    
    func tappedLoginButton() {
        // Desativa o botão temporariamente para evitar cliques duplos durante a requisição
        screen.setLoginButton(isEnabled: false)
        viewModel.performLogin()
    }
}
