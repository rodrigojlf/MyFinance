//
//  SplashViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let viewModel: SplashViewModel
    private let screen: SplashScreen = SplashScreen()
    
    init(viewModel: SplashViewModel) {
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
//        viewModel.startSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            // Inicia a animação da View
            screen.startLogoAnimation()
            
            // Inicia o timer da ViewModel para navegação
            viewModel.startSetup()
        }
}
