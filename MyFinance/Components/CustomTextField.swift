//
//  CustomTextField.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

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
        
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textColor = .systemGray
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        layer.borderWidth = 1
//        layer.borderColor = UIColor.systemGray5.cgColor
        
        changeVisualState(to: .normal)
        
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupActions() {
        // Escuta quando o usuário clica no campo
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        // Escuta quando o usuário sai do campo ou aperta Return
        addTarget(self, action: #selector(didEndEditing), for: .editingDidEnd)
        // Escuta cada tecla digitada (opcional, para tirar o vermelho enquanto corrige)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func didBeginEditing() {
        changeVisualState(to: .active) // Fica Rosa
    }
    
    @objc private func didEndEditing() {
        // Quando o usuário termina de digitar, rodamos a validação
        if let text = self.text, !text.isEmpty, let rule = validationRule {
            let isValid = rule(text)
            changeVisualState(to: isValid ? .normal : .error)
        } else {
            // Se estiver vazio, volta pro normal
            changeVisualState(to: .normal)
        }
    }
    
    @objc private func textDidChange() {
        // Quando o usuário começa a apagar/digitar para corrigir o erro, voltamos para a cor de edição
        changeVisualState(to: .active)
    }
    
    private func changeVisualState(to state: TextFieldState) {
        switch state {
        case .normal:
            layer.borderColor = UIColor.systemGray5.cgColor
            iconImageView?.tintColor = UIColor.systemGray
        case .active:
            layer.borderColor = UIColor(red: 218/255, green: 75/255, blue: 221/255, alpha: 1.0).cgColor // Borda Rosa
            iconImageView?.tintColor = UIColor(red: 218/255, green: 75/255, blue: 221/255, alpha: 1.0)  // Ícone Rosa
        case .error:
            layer.borderColor = UIColor.systemRed.cgColor  // Borda Vermelha
            iconImageView?.tintColor = UIColor.systemRed   // Ícone Vermelho
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
