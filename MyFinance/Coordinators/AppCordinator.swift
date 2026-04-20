//
//  AppCordinator.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let authService: AuthServiceProtocol
    
    init(navigationController: UINavigationController, authService: AuthServiceProtocol = AuthenticationService()) {
        self.navigationController = navigationController
        self.authService = authService
    }
    
    func start() {
        showSplashScreen()
    }
    
    private func showSplashScreen() {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        
        viewModel.onFinishSplash = { [weak self] in
            self?.routeAfterSplash()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func routeAfterSplash() {
        if authService.hasActiveSession() {
            print("Usuário logado.")
            showHomeScreen()
        } else {
            print("Usuário não logado.")
            showLoginScreen()
        }
    }
    
    private func showLoginScreen() {
        let viewModel = LoginViewModel(authService: authService)
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.showHomeScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showHomeScreen() {
        let viewModel = HomeViewModel(authService: authService)
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewModel.onAddTransactionRequested = { [weak self] in
            self?.showAddTransaction()
        }
        
        viewModel.onSettingsRequested = { [weak self] in
            self?.showBudgetSettings()
        }
        
        viewModel.onLogoutSuccess = { [weak self] in
            self?.showLoginScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showBudgetSettings() {
        let viewModel = BudgetSettingsViewModel()
        let viewController = BudgetSettingsViewController(viewModel: viewModel)
        
        viewModel.onBackRequested = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showAddTransaction() {
        let viewModel = AddTransactionViewModel()
        let viewController = AddTransactionViewController(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
}
