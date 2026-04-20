//
//  HomeScreen.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class HomeScreen: UIView {
    
    var budget: Budget?
    
    lazy var headerView = HomeHeaderView()
    
    lazy var monthCarouselView: MonthCarouselView = {
        let view = MonthCarouselView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let budgetCard = BudgetCardView()
    
    private lazy var tableTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .title2Xs
        label.textColor = .gray600
        label.textAlignment = .left
        label.text = "LANÇAMENTOS"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var numberOfTransactionsLabel: UILabel = {
        let label = UILabel()
        label.font = .titleXs
        label.textColor = .gray600
        label.textAlignment = .center
        label.text = "0" // alterar dinamicamente
        label.backgroundColor = .gray300
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableHeaderView = UIView()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .gray100
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.layer.cornerRadius = 12
        table.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var fabButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray700
        button.tintColor = .gray100
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        button.layer.cornerRadius = 28
        button.layer.shadowColor = UIColor.gray700.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    init(budget: Budget? = nil) {
        super.init(frame: .zero)
        self.budget = budget
        setupView()
        setupConstraints()
        setupTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .gray200
        
        addSubview(headerView)
        addSubview(monthCarouselView)
        addSubview(budgetCard)
        addSubview(tableView)
        addSubview(fabButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            monthCarouselView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            monthCarouselView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthCarouselView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            budgetCard.topAnchor.constraint(equalTo: monthCarouselView.bottomAnchor, constant: 16),
            budgetCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            budgetCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            budgetCard.heightAnchor.constraint(equalToConstant: 214),
            
            tableView.topAnchor.constraint(equalTo: budgetCard.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            fabButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            fabButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6),
            fabButton.widthAnchor.constraint(equalToConstant: 56),
            fabButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTableHeaderView() {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40)
        tableHeaderView.backgroundColor = .gray100
        tableHeaderView.layer.borderColor = UIColor.gray300.cgColor
        tableHeaderView.layer.borderWidth = 0.33
        
        tableHeaderView.addSubview(tableTitleLabel)
        tableHeaderView.addSubview(numberOfTransactionsLabel)
        
        NSLayoutConstraint.activate([
            tableTitleLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 20),
            tableTitleLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 15),
            tableTitleLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -15),
            
            numberOfTransactionsLabel.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -20),
            numberOfTransactionsLabel.centerYAnchor.constraint(equalTo: tableTitleLabel.centerYAnchor),
            numberOfTransactionsLabel.widthAnchor.constraint(equalToConstant: 24),
            numberOfTransactionsLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
        
        tableView.tableHeaderView = tableHeaderView
    }
}
