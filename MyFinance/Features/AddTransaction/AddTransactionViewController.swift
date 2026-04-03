//
//  AddTransactionViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class AddTransactionViewController: UIViewController {
    
    private let viewModel: AddTransactionViewModel
    private let customView = AddTransactionView()
    
    init(viewModel: AddTransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() { self.view = customView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSheet()
        setupActions()
    }
    
    private func setupSheet() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }
    
    private func setupActions() {
        customView.typeSelector.onTypeChanged = { [weak self] type in
            self?.viewModel.updateType(type)
        }
        
        customView.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func saveTapped() {
        viewModel.saveTransaction(
            title: customView.titleInput.text,
            category: customView.categoryInput.text,
            amount: customView.amountInput.text,
            date: customView.dateInput.text
        )
        
        viewModel.onSaveSuccess = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
