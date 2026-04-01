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
            self?.showWelcomeScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showWelcomeScreen() {
        let welcomeVC = UIViewController()
        welcomeVC.view.backgroundColor = .appMagenta
        
        navigationController.setViewControllers([welcomeVC], animated: true)
    }
}
