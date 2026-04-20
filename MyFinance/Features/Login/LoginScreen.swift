//
//  LoginScreen.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func tappedLoginButton()
    func nameDidChange(text: String)
    func emailDidChange(text: String)
    func passwordDidChange(text: String)
}

final class LoginScreen: UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    public func delegate(delegate: LoginScreenProtocol) {
        self.delegate = delegate
    }
    
    private var hidePassword: Bool = false
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "login-header")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
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
    private lazy var passwordInput = CustomTextField(placeholder: "Senha", isPassword: hidePassword)
    
    private lazy var hidePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eye-closed"), for: .normal)
        button.tintColor = UIColor.systemGray
        button.currentImage?.withRenderingMode(.alwaysTemplate)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleHidePassword), for: .touchUpInside)
        return button
    }()
    
    @objc private func toggleHidePassword() {
        hidePassword.toggle()
        passwordInput.isSecureTextEntry = hidePassword
        let iconName = hidePassword ? "eye-closed" : "eye"
        hidePasswordButton.setImage(UIImage(named: iconName), for: .normal)
    }
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray300
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton(title: "Entrar")
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func tappedLoginButton() {
        delegate?.tappedLoginButton()
    }
    
    private lazy var formStackView: UIStackView = {
        let stack = UIStackView()
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
        backgroundColor = .gray100
        
        addSubview(headerImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(formStackView)
        addSubview(dividerView)
        addSubview(loginButton)
        formStackView.addArrangedSubview(nameInput)
        formStackView.addArrangedSubview(emailInput)
        formStackView.addArrangedSubview(passwordInput)
        passwordInput.addSubview(hidePasswordButton)
        
        setupConstraints()
        setupTextFieldActions()
        setLoginButton(isEnabled: false)
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
            
            hidePasswordButton.centerYAnchor.constraint(equalTo: passwordInput.centerYAnchor),
            hidePasswordButton.trailingAnchor.constraint(equalTo: passwordInput.trailingAnchor, constant: -16),
            hidePasswordButton.widthAnchor.constraint(equalToConstant: 30),
            hidePasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            dividerView.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -28),
            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    private func setupTextFieldActions() {
        nameInput.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        emailInput.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }
    
    @objc private func nameChanged(_ textField: UITextField) {
        delegate?.nameDidChange(text: textField.text ?? "")
    }
    
    @objc private func emailChanged(_ textField: UITextField) {
        delegate?.emailDidChange(text: textField.text ?? "")
    }
    
    @objc private func passwordChanged(_ textField: UITextField) {
        delegate?.passwordDidChange(text: textField.text ?? "")
    }
    
    func setNameError(_ hasError: Bool) {
        nameInput.setVisualState(hasError: hasError)
    }
    
    func setEmailError(_ hasError: Bool) {
        emailInput.setVisualState(hasError: hasError)
    }
    
    func setPasswordError(_ hasError: Bool) {
        passwordInput.setVisualState(hasError: hasError)
    }
    
    func setLoginButton(isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    //Facilitar os testes de login
    func injectLoginData() {
        nameInput.text = "JONAS"
        nameChanged(nameInput)
        emailInput.text = "teste@email.com"
        emailChanged(emailInput)
        passwordInput.text = "teste123"
        passwordInput.isSecureTextEntry = true
        passwordChanged(passwordInput)
    }
}
