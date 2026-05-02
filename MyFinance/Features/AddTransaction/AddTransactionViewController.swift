//
//  AddTransactionViewController.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class AddTransactionViewController: UIViewController {
    
    private let viewModel: AddTransactionViewModel
    private let screen = AddTransactionScreen()
    
    init(viewModel: AddTransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSheet()
        screen.delegate(delegate: self)
        screen.categoryTextField.delegate = self
        screen.amountTextField.delegate = self
        screen.dateTextField.delegate = self
    }
    
    private func setupSheet() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = false
        }
    }
    
    func saveErrorAlert() {
        AlertManager.showAlert(on: self, title: "Erro ao salvar", message: "Não existe orçamento cadastrado para a data especificada.")
    }
}

extension AddTransactionViewController: AddTransactionScreenProtocol {
    func dismissAction() {
        self.dismiss(animated: true)
    }
    
    func addTransaction() {
        viewModel.saveTransaction(title: screen.getTitle(),
                                  category: screen.getCategory(),
                                  date: screen.getDate(),
                                  amount: screen.getAmount(),
                                  type: screen.getTransactionType())
    }
}

extension AddTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == screen.categoryTextField || textField == screen.dateTextField {
            return false // Bloqueia qualquer caractere digitado ou colado
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.isEmpty {
            textField.text = ""
            return false
        }
        
        if textField == screen.amountTextField {
            textField.text = updatedText.currencyFormatting()
            return false
            
        } else if textField == screen.dateTextField {
            textField.text = updatedText.dateFormatting()
            return false
        }
        
        return true
    }
}
