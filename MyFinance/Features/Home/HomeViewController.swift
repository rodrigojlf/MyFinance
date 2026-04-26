//
//  HomeViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    private let screen = HomeScreen()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.tableView.delegate = self
        screen.tableView.dataSource = self
        
        setupBindings()
        setupActions()
        viewModel.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let index = viewModel.selectedMonthIndex
        screen.monthCarouselView.scrollToItem(at: index)
        initialSetup()
    }
    
    private func setupBindings() {
        screen.monthCarouselView.onMonthChanged = { [unowned self] month in
            self.viewModel.selectedMonthIndex = month
            self.screen.tableView.reloadData()
            self.screen.budgetCard.setupBudget(budget: self.viewModel.currentBudget,
                                               for: self.viewModel.currentMonthYear)
            self.screen.updateNumberOfTransactions(for: self.viewModel.filteredTransactions.count)
        }
        
        viewModel.onDataUpdated = { [weak self] in
            self?.screen.tableView.reloadData()
            self?.screen.updateNumberOfTransactions(for: self?.viewModel.filteredTransactions.count ?? 0)
        }
        
        viewModel.onLogoutFailure = { [weak self] errorMessage in
            AlertManager.showAlert(on: self, title: "Erro no logout", message: errorMessage)
        }
    }
    
    private func setupActions() {
        screen.onFabButtonTapped = { [weak self] in
            self?.viewModel.didTapAddTransaction()
        }
        
        screen.budgetCard.onSettingsTapped = { [weak self] in
            self?.viewModel.didTapSettings()
        }
        
        screen.headerView.onLogoutButtonTapped = { [weak self] in
            self?.viewModel.logout()
        }
    }
    
    private func initialSetup() {
        screen.headerView.setupHeaderData(name: viewModel.user?.name ?? "erro", data: nil)
        screen.tableView.reloadData()
        screen.budgetCard.setupBudget(
            budget: viewModel.currentBudget,
            for: viewModel.currentMonthYear
        )
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.filteredTransactions.count > 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else {
                return UITableViewCell()
            }
            
            let transaction = viewModel.filteredTransactions[indexPath.row]
            cell.configure(with: transaction)
            return cell
        } else {
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: EmptyTransactionCell.identifier, for: indexPath) as? EmptyTransactionCell else {
                return UITableViewCell()
            }
            return emptyCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt
    }
}
