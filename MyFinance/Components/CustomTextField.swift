//
//  CustomTextField.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    init(placeholder: String, isPassword: Bool = false) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, isPassword: isPassword)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField(placeholder: String, isPassword: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.isSecureTextEntry = isPassword
        
        font = .input
        textColor = .gray700
        backgroundColor = .gray100
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray200.cgColor
        
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
