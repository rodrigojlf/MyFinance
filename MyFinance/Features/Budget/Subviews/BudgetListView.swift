//
//  BudgetListView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 17/04/26.
//

import UIKit

final class BudgetListView: UIView {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .gray100
        table.layer.cornerRadius = 12
        
        table.register(BudgetCell.self, forCellReuseIdentifier: BudgetCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var tableHeaderView = UIView()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "ORÇAMENTOS CADASTRADOS"
        label.font = .title2Xs
        label.textColor = .gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .gray100
        layer.cornerRadius = 12
        layer.borderColor = UIColor.gray300.cgColor
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupTableHeaderView() {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40)
        tableHeaderView.backgroundColor = .gray100
        tableHeaderView.layer.borderColor = UIColor.gray300.cgColor
        tableHeaderView.layer.borderWidth = 0.5
        
        tableHeaderView.addSubview(headerTitleLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 14),
            headerTitleLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 20),
            headerTitleLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -14),
        ])
        
        tableView.tableHeaderView = tableHeaderView
    }
}
