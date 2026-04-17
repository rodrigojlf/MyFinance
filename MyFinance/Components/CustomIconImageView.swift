//
//  CustomIconImageView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 13/04/26.
//

import UIKit

final class CustomIconImageView: UIImageView {
    
    init(symbol: String) {
        super.init(frame: .zero)
        setupImage(symbol: symbol)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage(symbol: String) {
        image = UIImage(systemName: symbol)
        tintColor = UIColor.gray
        contentMode = .scaleAspectFit
    }
}
