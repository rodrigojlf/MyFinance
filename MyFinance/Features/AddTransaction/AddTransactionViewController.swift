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
        screen.amountTextField.delegate = self
        screen.dateTextField.delegate = self
    }
    
    private func setupSheet() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = false
        }
    }
}

extension AddTransactionViewController: AddTransactionScreenProtocol {
    func dismissAction() {
        self.dismiss(animated: true)
    }
    
    func addTransaction() {
        viewModel.saveTransaction(title: screen.getTitle(), // Tratar opcionais na ViewModel
                                  date: screen.getDate(),
                                  amount: screen.getAmount(),
                                  type: screen.getTransactionType())
    }
    
    
}

extension AddTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            // Pega o texto atual do campo
            let currentText = textField.text ?? ""
            
            // Verifica se é o comportamento de apagar tudo de uma vez (ex: select all + backspace)
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            // Cria a nova string simulando o que aconteceria após o usuário digitar
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // Se o usuário apagou tudo, deixamos o campo vazio
            if updatedText.isEmpty {
                textField.text = ""
                return false
            }
            
            // --- APLICAÇÃO DAS MÁSCARAS ---
            
            // Verifique qual textField está sendo editado para aplicar a máscara correta
        if textField == screen.amountTextField { // Substitua pelo nome da sua variável
                textField.text = updatedText.currencyFormatting()
                return false // Retornamos false para que o iOS não coloque o texto "cru", nós já colocamos o texto formatado acima.
                
        } else if textField == screen.dateTextField { // Substitua pelo nome da sua variável
                textField.text = updatedText.dateFormatting()
                return false
            }
            
            // Para qualquer outro textField que não tenha máscara, permite a digitação normal
            return true
        }
}
