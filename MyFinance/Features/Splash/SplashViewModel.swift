//
//  SplashViewModel.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import Foundation

final class SplashViewModel {
    
    var onFinishSplash: (() -> Void)?
    
    func startSetup() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.onFinishSplash?()
        }
    }
}
