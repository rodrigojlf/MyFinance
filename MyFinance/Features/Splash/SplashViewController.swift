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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = screen
        viewModel.startSetup()
    }
    
    
}
