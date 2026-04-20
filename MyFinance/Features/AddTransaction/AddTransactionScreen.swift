//
//  AddTransactionScreen.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

protocol AddTransactionScreenProtocol: AnyObject {
    func dismissAction()
    func addTransaction()
}

final class AddTransactionScreen: UIView {
    
    var transactionType: TransactionType?
    
    private weak var delegate: AddTransactionScreenProtocol?
    
    func delegate(delegate: AddTransactionScreenProtocol) {
        self.delegate = delegate
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NOVO LANÇAMENTO"
        label.font = .titleSm
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.tintColor = .gray500
        btn.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc private func dismissAction() {
        self.delegate?.dismissAction()
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var transactionTextField: CustomTextField = CustomTextField(placeholder: "Título da transação")
    
    private lazy var priceTagIcon: CustomIconImageView = {
        let img = CustomIconImageView(symbol: "tag")
        img.transform = CGAffineTransform(scaleX: -1, y: 1)
        return img
    }()
    
    private lazy var categoryTextField: CustomTextField = CustomTextField(placeholder: "Categoria", icon: priceTagIcon)
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var brazilianRealSignIcon = CustomIconImageView(symbol: "brazilianrealsign")
    
    lazy var amountTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "0,00", icon: brazilianRealSignIcon)
        tf.keyboardType = .numberPad
        return tf
    }()
    
    private lazy var calendarIcon = CustomIconImageView(symbol: "calendar")
    
    lazy var dateTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "dd/MM/yyyy", icon: calendarIcon)
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(validateDateTextField), for: .editingDidEnd)
        tf.addTarget(self, action: #selector(clearDateError), for: .editingChanged)
        
        return tf
    }()
    
    @objc private func clearDateError() {
        dateTextField.setVisualState(hasError: false)
    }
    
    @objc private func validateDateTextField() {
        guard let textDigitado = dateTextField.text, !textDigitado.isEmpty else {
            dateTextField.setVisualState(hasError: false)
            return
        }
        
        let isValid: Bool
        
        if textDigitado.count < 10 {
            isValid = false
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "pt_BR")
            isValid = formatter.date(from: textDigitado) != nil
        }
        
        dateTextField.setVisualState(hasError: !isValid)
    }
    
    private lazy var buttonsHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var incomeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = .buttonSm
        config.attributedTitle = AttributedString("Entrada", attributes: container)
        config.image = UIImage(named: "caret-up-fill")?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.background.cornerRadius = 8
        config.background.strokeColor = .appGreen
        config.background.strokeWidth = 2
        config.background.backgroundColor = .appGreen.withAlphaComponent(0.05)
        
        let toggleAction = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            button.isSelected.toggle()
        }
        let actionButton = UIButton(configuration: config, primaryAction: toggleAction)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            if button.isSelected {
                updatedConfig?.baseForegroundColor = .gray100
                updatedConfig?.background.backgroundColor = .appGreen
            } else {
                updatedConfig?.baseForegroundColor = .appGreen
            }
            button.configuration = updatedConfig
        }
        actionButton.addTarget(self, action: #selector(tapIncomeButton), for: .touchUpInside)
        return actionButton
    }()
    
    @objc private func tapIncomeButton() {
        transactionType = .income
        expenseButton.isSelected = false
        expenseButton.configuration?.background.strokeWidth = 0
        expenseButton.configuration?.background.backgroundColor = .gray200
    }
    
    private lazy var expenseButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = .buttonSm
        config.attributedTitle = AttributedString("Saída", attributes: container)
        config.image = UIImage(named: "caret-down-fill")?.withRenderingMode(.alwaysTemplate)
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.background.backgroundColor = .appRed.withAlphaComponent(0.05)
        config.background.cornerRadius = 8
        config.background.strokeColor = .appRed
        config.background.strokeWidth = 2
        
        let toggleAction = UIAction { action in
            guard let button = action.sender as? UIButton else { return }
            button.isSelected.toggle()
        }
        let actionButton = UIButton(configuration: config, primaryAction: toggleAction)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            if button.isSelected {
                updatedConfig?.baseForegroundColor = .gray100
                updatedConfig?.background.backgroundColor = .appRed
            } else {
                updatedConfig?.baseForegroundColor = .appRed
            }
            button.configuration = updatedConfig
        }
        
        actionButton.addTarget(self, action: #selector(tapExpenseButton), for: .touchUpInside)
        return actionButton
    }()
    
    @objc private func tapExpenseButton() {
        transactionType = .expense
        incomeButton.isSelected = false
        incomeButton.configuration?.background.strokeWidth = 0
        incomeButton.configuration?.background.backgroundColor = .gray200
    }
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        view.layer.opacity = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var saveButton: PrimaryButton = {
        let btn = PrimaryButton(title: "Salvar")
        btn.addTarget(self, action: #selector(saveTransaction), for: .touchUpInside)
        return btn
    }()
    
    @objc private func saveTransaction() {
        self.delegate?.addTransaction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .gray100
        addSubview(titleLabel)
        addSubview(dismissButton)
        addSubview(stackView)
        stackView.addArrangedSubview(transactionTextField)
        stackView.addArrangedSubview(categoryTextField)
        categoryTextField.addSubview(priceTagIcon)
        stackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(amountTextField)
        amountTextField.addSubview(brazilianRealSignIcon)
        horizontalStackView.addArrangedSubview(dateTextField)
        dateTextField.addSubview(calendarIcon)
        addSubview(buttonsHorizontalStackView)
        buttonsHorizontalStackView.addArrangedSubview(incomeButton)
        buttonsHorizontalStackView.addArrangedSubview(expenseButton)
        addSubview(dividerView)
        addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            dismissButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            transactionTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -48),
            
            categoryTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -48),
            
            horizontalStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -48),
            
            buttonsHorizontalStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            buttonsHorizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsHorizontalStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -48),
            buttonsHorizontalStackView.heightAnchor.constraint(equalToConstant: 48),
            
            incomeButton.heightAnchor.constraint(equalTo: buttonsHorizontalStackView.heightAnchor),
            expenseButton.heightAnchor.constraint(equalTo: buttonsHorizontalStackView.heightAnchor),
            
            dividerView.topAnchor.constraint(equalTo: buttonsHorizontalStackView.bottomAnchor, constant: 24),
            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dividerView.widthAnchor.constraint(equalTo: buttonsHorizontalStackView.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            saveButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 24),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: buttonsHorizontalStackView.widthAnchor)
            
        ])
    }
    
    func getTitle() -> String? {
        return transactionTextField.text
    }
    
    func getCategory() -> String? {
        return categoryTextField.text
    }
    
    func getAmount() -> String? {
        return amountTextField.text
    }
    
    func getDate() -> String? {
        return dateTextField.text
    }
    
    func getTransactionType() -> TransactionType? {
        return transactionType
    }
}
