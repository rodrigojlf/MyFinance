//
//  AppCordinator.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSplashScreen()
    }
    
    private func showSplashScreen() {
        let viewModel = SplashViewModel()
        let viewController = SplashViewController(viewModel: viewModel)
        
        viewModel.onFinishSplash = { [weak self] in
            self?.showLoginScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showLoginScreen() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.showHomeScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showHomeScreen() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewModel.onAddTransactionRequested = { [weak self] in self?.showAddTransaction() }
        viewModel.onSettingsRequested = { [weak self] in self?.showBudgetSettings() } // NOVO
        
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
