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
    
    var validationRule: ((String) -> Bool)?
    
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
        
        font = .input
        textColor = .gray700
        backgroundColor = .gray100
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray200.cgColor
        
        changeVisualState(to: .normal)
        
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
    
    private func setupActions() {
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func didBeginEditing() {
        changeVisualState(to: .active)
    }
    
    @objc private func didEndEditing() {
        if let text = self.text, !text.isEmpty, let rule = validationRule {
            let isValid = rule(text)
            changeVisualState(to: isValid ? .normal : .error)
        } else {
            changeVisualState(to: .normal)
        }
    }
    
    @objc private func textDidChange() {
        changeVisualState(to: .active)
    }
    
    private func changeVisualState(to state: TextFieldState) {
        switch state {
        case .normal:
            layer.borderColor = UIColor.gray200.cgColor
            iconImageView?.tintColor = UIColor.gray700
        case .active:
            layer.borderColor = UIColor.appMagenta.cgColor
            iconImageView?.tintColor = UIColor.appMagenta
        case .error:
            layer.borderColor = UIColor.appRed.cgColor
            iconImageView?.tintColor = UIColor.appRed
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let iconSize: CGFloat = 24
        let leftMargin: CGFloat = 12
        let yPosition = (bounds.height - iconSize) / 2
        
        return CGRect(x: leftMargin, y: yPosition, width: iconSize, height: iconSize)
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
