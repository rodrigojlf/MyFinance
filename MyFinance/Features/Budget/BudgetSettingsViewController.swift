//
//  BudgetSettingsViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class BudgetSettingsViewController: UIViewController {
    
    private let viewModel: BudgetSettingsViewModel
    private let screen = BudgetSettingsView()
    
    init(viewModel: BudgetSettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() { self.view = screen }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        setupActions()
        viewModel.loadData()
    }
    
    private func setupTableView() {
        screen.budgetListView.tableView.delegate = self
        screen.budgetListView.tableView.dataSource = self
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.screen.budgetListView.tableView.reloadData()
        }
    }
    
    private func setupActions() {
        screen.header.dismiss = { [weak self] in
            self?.viewModel.goBack()
        }
        screen.newBudgetSection.saveAction = { [weak self] in
            self?.viewModel.addBudget(monthYear: self?.screen.newBudgetSection.dateTextField.text,
                                      amount: self?.screen.newBudgetSection.amountTextField.text)
            self?.screen.newBudgetSection.dateTextField.text = ""
            self?.screen.newBudgetSection.amountTextField.text = ""
            self?.view.endEditing(true)
        }
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
        cell.onSwipeThresholdReached = { [weak self] in
            AlertManager.showConfirmation(on: self, title: "Apagar Orçamento", message: "Tem certeza?") {
                cell.resetPanPosition(animated: true)
                self?.viewModel.removeBudget(at: indexPath.row)
            } onCancel: {
                cell.resetPanPosition(animated: true)
            }

        }
        cell.onDeleteTapped = { [weak self] in
            AlertManager.showConfirmation(on: self, title: "Apagar Orçamento", message: "Tem certeza?") {
                self?.viewModel.removeBudget(at: indexPath.row)
            } onCancel: {}
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
