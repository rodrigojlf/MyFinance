//
//  BudgetSettingsView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class BudgetSettingsView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .gray700
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ORÇAMENTOS MENSAIS"
        label.font = .titleSm
        label.textColor = .gray700
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Organize seus limites de gastos por mês"
        label.font = .textSm
        label.textColor = .gray500
        return label
    }()
    
    private lazy var newBudgetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NOVO ORÇAMENTO"
        label.font = .titleXs
        label.textColor = .gray500
        return label
    }()
    
    lazy var monthInput = CustomTextField(placeholder: "00/0000")
    lazy var amountInput = CustomTextField(placeholder: "R$ 0,00")
    lazy var addButton = PrimaryButton(title: "Adicionar")
    
    private lazy var inputStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [monthInput, amountInput])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private lazy var registeredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ORÇAMENTOS CADASTRADOS"
        label.font = .titleXs
        label.textColor = .gray500
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.identifier)
        return table
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        addSubview(newBudgetLabel)
        addSubview(inputStackView)
        addSubview(addButton)
        
        addSubview(registeredLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            newBudgetLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            newBudgetLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            inputStackView.topAnchor.constraint(equalTo: newBudgetLabel.bottomAnchor, constant: 16),
            inputStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            addButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 16),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            registeredLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 40),
            registeredLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            tableView.topAnchor.constraint(equalTo: registeredLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
