//
//  TransactionTypeSelector.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class TransactionTypeSelector: UIView {
    
    var onTypeChanged: ((TransactionType) -> Void)?
    private var selectedType: TransactionType = .expense
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [incomeButton, expenseButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    private lazy var incomeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Entrada", for: .normal)
        btn.titleLabel?.font = .buttonSm
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(incomeTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var expenseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Saída", for: .normal)
        btn.titleLabel?.font = .buttonSm
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(expenseTapped), for: .touchUpInside)
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        updateVisuals()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func incomeTapped() {
        selectedType = .income
        updateVisuals()
        onTypeChanged?(.income)
    }
    
    @objc private func expenseTapped() {
        selectedType = .expense
        updateVisuals()
        onTypeChanged?(.expense)
    }
    
    private func updateVisuals() {
        if selectedType == .income {
            incomeButton.backgroundColor = .appGreen.withAlphaComponent(0.1)
            incomeButton.layer.borderColor = UIColor.appGreen.cgColor
            incomeButton.setTitleColor(.appGreen, for: .normal)
            
            expenseButton.backgroundColor = .gray100
            expenseButton.layer.borderColor = UIColor.gray200.cgColor
            expenseButton.setTitleColor(.gray500, for: .normal)
        } else {
            expenseButton.backgroundColor = .appRed.withAlphaComponent(0.1)
            expenseButton.layer.borderColor = UIColor.appRed.cgColor
            expenseButton.setTitleColor(.appRed, for: .normal)
            
            incomeButton.backgroundColor = .gray100
            incomeButton.layer.borderColor = UIColor.gray200.cgColor
            incomeButton.setTitleColor(.gray500, for: .normal)
        }
    }
}
