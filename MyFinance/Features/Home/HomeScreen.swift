//
//  HomeScreen.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class HomeScreen: UIView {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        return table
    }()
    
    let headerContainer = UIView()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .titleSm
        label.textColor = .gray700
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vamos organizar suas finanças?"
        label.font = .textSm
        label.textColor = .gray500
        return label
    }()
    
    let budgetCard = BudgetCardView()
    
    private lazy var transactionsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LANÇAMENTOS"
        label.font = .titleXs
        label.textColor = .gray700
        return label
    }()
    
    lazy var fabButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray700
        button.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        return button
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
        
        addSubview(tableView)
        addSubview(fabButton)
        
        setupHeader()
        setupConstraints()
    }
    
    private func setupConstraints() {
    NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        fabButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        fabButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
        fabButton.widthAnchor.constraint(equalToConstant: 56),
        fabButton.heightAnchor.constraint(equalToConstant: 56)
    ])
}
    
    private func setupHeader() {
        headerContainer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 360)
        
        headerContainer.addSubview(greetingLabel)
        headerContainer.addSubview(subtitleLabel)
        headerContainer.addSubview(budgetCard)
        headerContainer.addSubview(transactionsTitleLabel)
        
        setupHeaderConstraints()
        
        tableView.tableHeaderView = headerContainer
    }
    
    private func setupHeaderConstraints() {
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 16),
            greetingLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 24),
            
            subtitleLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 24),
            
            budgetCard.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            budgetCard.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 24),
            budgetCard.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -24),
            
            transactionsTitleLabel.topAnchor.constraint(equalTo: budgetCard.bottomAnchor, constant: 32),
            transactionsTitleLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 24),
            transactionsTitleLabel.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        ])
    }
    
    
    func setupHeaderData(name: String, amount: String, used: String, limit: String, progress: Float) {
        greetingLabel.text = "OLÁ, \(name.uppercased())"
        budgetCard.setup(amount: amount, used: used, limit: limit, progress: progress)
    }
}
