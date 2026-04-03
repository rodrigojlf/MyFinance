//
//  BudgetSettingsViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class BudgetSettingsViewController: UIViewController {
    
    private let viewModel: BudgetSettingsViewModel
    private let customView = BudgetSettingsView()
    
    init(viewModel: BudgetSettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() { self.view = customView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        setupActions()
        viewModel.loadData()
    }
    
    private func setupTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.customView.tableView.reloadData()
        }
    }
    
    private func setupActions() {
        customView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        customView.addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() { viewModel.goBack() }
    
    @objc private func addTapped() {
        viewModel.addBudget(monthYear: customView.monthInput.text, amount: customView.amountInput.text)
        // Limpar inputs após adicionar
        customView.monthInput.text = ""
        customView.amountInput.text = ""
        view.endEditing(true)
    }
}

extension BudgetSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.budgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BudgetCell.identifier, for: indexPath) as? BudgetCell else { return UITableViewCell() }
        
        let budget = viewModel.budgets[indexPath.row]
        cell.configure(with: budget)
        
        cell.onDeleteTapped = { [weak self] in
            self?.viewModel.removeBudget(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
