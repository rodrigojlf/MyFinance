//
//  AddTransactionView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class AddTransactionView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NOVO LANÇAMENTO"
        label.font = .titleSm
        label.textColor = .gray700
        return label
    }()
    
    lazy var titleInput = CustomTextField(placeholder: "Título da transação")
    lazy var categoryInput = CustomTextField(placeholder: "Categoria")
    lazy var amountInput = CustomTextField(placeholder: "R$ 0,00")
    lazy var dateInput = CustomTextField(placeholder: "00/00/0000")
    
    lazy var typeSelector = TransactionTypeSelector()
    lazy var saveButton = PrimaryButton(title: "Salvar")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleInput, categoryInput])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountInput, dateInput])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private lazy var typeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeSelector])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(horizontalStack)
        addSubview(typeSelector)
        addSubview(saveButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        typeSelector.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            horizontalStack.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            typeSelector.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 24),
            typeSelector.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            typeSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            saveButton.topAnchor.constraint(equalTo: typeSelector.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            saveButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -40)
        ])
    }
}
