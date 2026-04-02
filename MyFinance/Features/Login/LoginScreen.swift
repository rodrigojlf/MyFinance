//
//  LoginScreen.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func tappedLoginButton()
}

final class LoginScreen: UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    public func delegate(delegate: LoginScreenProtocol) {
        self.delegate = delegate
    }
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "login-header")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BOAS VINDAS!"
        label.font = .titleSm
        label.textColor = .gray700
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pronto para organizar suas finanças? Acesse agora"
        label.font = .textSm
        label.textColor = .gray500
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameInput = CustomTextField(placeholder: "Nome")
    private lazy var emailInput = CustomTextField(placeholder: "E-mail")
    private lazy var passwordInput = CustomTextField(placeholder: "Senha", isPassword: true)
        
    lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton(title: "Entrar")
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedLoginButton() {
        delegate?.tappedLoginButton()
    }
    
    private lazy var formStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameInput, emailInput, passwordInput])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(headerImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(formStackView)
        addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            titleLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            formStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            formStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            formStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
