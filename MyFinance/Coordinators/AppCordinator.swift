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
        
        // Quando o login der sucesso, navegar para a Home
        viewModel.onLoginSuccess = { [weak self] in
            self?.showHomeScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showHomeScreen() {
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .gray200
        navigationController.setViewControllers([homeVC], animated: true)
    }
}
