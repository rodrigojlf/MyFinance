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
        
        screen.monthCarouselView.delegate = self
        
        setupBindings()
        setupActions()
        viewModel.loadData()
        
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            
            self.screen.tableView.reloadData()
        }
    }
    
    private func setupActions() {
        screen.fabButton.addTarget(self, action: #selector(fabTapped), for: .touchUpInside)
        screen.budgetCard.onSettingsTapped = { [weak self] in self?.viewModel.didTapSettings() }
    }
    
    @objc private func fabTapped() {
        viewModel.didTapAddTransaction()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        
        let transaction = viewModel.transactions[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension HomeViewController: MonthCarouselViewDelegate {
    
    func monthCarouselView(_ view: MonthCarouselView, didSelectMonthAt monthIndex: Int) {
        // Método  para integrar a lógica de atualização.
        print("Mês atual: \(monthIndex).")
        
        // TO DO - viewModel.loadTransactions(forMonth: monthIndex)
    }
}
