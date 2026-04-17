//
//  HomeHeaderView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 06/04/26.
//

import UIKit

final class HomeHeaderView: UIView {
    
    var onLogoutButtonTapped: (() -> Void)?
    
    private lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "avatar") // carregar em outra tela
        img.tintColor = .gray700
        img.layer.cornerRadius = 20
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.gray700.cgColor
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.font = .titleSm
        label.textColor = .gray700
        label.text = "OLÁ, JONAS!" // carregar em outra tela
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Vamos organizar suas finanças?"
        label.font = .textSm
        label.textColor = .gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logout"), for: .normal)
        btn.tintColor = .gray500
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc private func logoutButtonTapped() {
        onLogoutButtonTapped?()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .gray100
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profileImageView)
        addSubview(greetingLabel)
        addSubview(subtitleLabel)
        addSubview(logoutButton)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
            greetingLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            
            subtitleLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor),
            
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            logoutButton.widthAnchor.constraint(equalToConstant: 24),
            logoutButton.heightAnchor.constraint(equalToConstant: 24),
            logoutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
        ])
    }
    
    
    
    func setupHeaderData(name: String, amount: String, used: String, limit: String, progress: Float) {
        greetingLabel.text = "OLÁ, \(name.uppercased())"
//        budgetCard.setup(amount: amount, used: used, limit: limit, progress: progress)
    }
}
