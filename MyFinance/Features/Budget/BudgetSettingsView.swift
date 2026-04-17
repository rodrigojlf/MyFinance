//
//  BudgetSettingsView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class BudgetSettingsView: UIView {
    
    lazy var header = BudgetHeaderView()
    
    lazy var newBudgetSection = NewBudgetSectionView()
    
    lazy var budgetListView = BudgetListView()
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .gray200
        
        addSubview(header)
        addSubview(newBudgetSection)
        addSubview(budgetListView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            newBudgetSection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            newBudgetSection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            newBudgetSection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            budgetListView.topAnchor.constraint(equalTo: newBudgetSection.bottomAnchor, constant: 16),
            budgetListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            budgetListView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            budgetListView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
