//
//  PrimaryButton.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.gray100, for: .normal)
        titleLabel?.font = .buttonMd
        backgroundColor = .appMagenta
        layer.cornerRadius = 8
        
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
