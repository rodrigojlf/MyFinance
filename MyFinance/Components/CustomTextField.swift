//
//  CustomTextField.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum TextFieldState {
        case normal
        case active
        case error
    }
    
    private var padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    private var iconImageView: UIImageView?
    
    init(placeholder: String, isPassword: Bool = false, icon: UIImageView? = nil) {
        super.init(frame: .zero)
        self.iconImageView = icon
        setupTextField(placeholder: placeholder, isPassword: isPassword, icon: icon)
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField(placeholder: String, isPassword: Bool, icon: UIImageView?) {
        
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.isSecureTextEntry = isPassword
        
        if let icon = icon {
            padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 16)
            self.leftView = icon
            self.leftViewMode = .always
        }
        
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textColor = .systemGray
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        layer.borderWidth = 1
        
        changeVisualState(to: .normal)
        
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupActions() {
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func didBeginEditing() {
        changeVisualState(to: .active)
    }
    
    @objc private func textDidChange() {
        changeVisualState(to: .active)
    }
    
    func setVisualState(hasError: Bool) {
        changeVisualState(to: hasError ? .error : .normal)
    }
    
    private func changeVisualState(to state: TextFieldState) {
        switch state {
        case .normal:
            layer.borderColor = UIColor.systemGray5.cgColor
            iconImageView?.tintColor = UIColor.systemGray
        case .active:
            layer.borderColor = UIColor(red: 218/255, green: 75/255, blue: 221/255, alpha: 1.0).cgColor
            iconImageView?.tintColor = UIColor(red: 218/255, green: 75/255, blue: 221/255, alpha: 1.0)
        case .error:
            layer.borderColor = UIColor.systemRed.cgColor
            iconImageView?.tintColor = UIColor.systemRed
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let iconSize: CGFloat = 24
        let leftMargin: CGFloat = 12
        let yPosition = (bounds.height - iconSize) / 2
        
        return CGRect(x: leftMargin, y: yPosition, width: iconSize, height: iconSize)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect { return bounds.inset(by: padding) }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect { return bounds.inset(by: padding) }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect { return bounds.inset(by: padding) }
}
