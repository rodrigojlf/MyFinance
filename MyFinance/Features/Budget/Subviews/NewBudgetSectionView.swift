//
//  NewBudgetSectionView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 14/04/26.
//

import UIKit

final class NewBudgetSectionView: UIView {
    
    var saveAction: (() -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray500
        label.font = .title2Xs
        label.textAlignment = .left
        label.text = "NOVO ORÇAMENTO"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray300
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var calendarIconImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "calendar")?.withRenderingMode(.alwaysTemplate))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray600
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    
    
    
    // MARK: - Picker Components

    // Array de meses formatados com dois dígitos ("01", "02", ... "12")
    private let months: [String] = (1...12).map { String(format: "%02d", $0) }

    // Array de anos dinâmico (do ano atual até 10 anos no futuro)
    private var years: [Int] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(currentYear...(currentYear + 10))
    }()

    private lazy var monthYearPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var datePickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        return toolbar
    }()

    @objc private func dismissPicker() {
        // Caso o usuário abra o picker e apenas clique em "OK" sem rolar,
        // garantimos que o texto será preenchido com a seleção atual.
        updateTextFieldWithSelectedDate()
        endEditing(true)
    }

    private func updateTextFieldWithSelectedDate() {
        let selectedMonth = months[monthYearPicker.selectedRow(inComponent: 0)]
        let selectedYear = years[monthYearPicker.selectedRow(inComponent: 1)]
        dateTextField.text = "\(selectedMonth)/\(selectedYear)"
    }
    
    
    
    
    
    
    
//    lazy var dateTextField = CustomTextField(placeholder: "00/0000", icon: calendarIconImageView)
    lazy var dateTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "00/0000", icon: calendarIconImageView)
        tf.inputView = monthYearPicker
        tf.inputAccessoryView = datePickerToolbar
        tf.tintColor = .clear
        tf.spellCheckingType = .no
        tf.autocorrectionType = .no
        return tf
    }()
    
    
    
    
    
    
    private lazy var currencyIconImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "brazilian-currency")?.withRenderingMode(.alwaysTemplate))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray600
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var amountTextField = CustomTextField(placeholder: "0,00", icon: currencyIconImageView)
    
    private lazy var saveButton: PrimaryButton = {
        let btn = PrimaryButton(title: "Adicionar")
        btn.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
        return btn
    }()
    
    @objc private func tappedSaveButton() {
        saveAction?()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupInitialPickerDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray100
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray300.cgColor
        
        addSubview(titleLabel)
        addSubview(dividerView)
        addSubview(hStackView)
        hStackView.addArrangedSubview(dateTextField)
        hStackView.addArrangedSubview(amountTextField)
        addSubview(saveButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            dividerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            dividerView.widthAnchor.constraint(equalTo: widthAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            hStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 20),
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStackView.heightAnchor.constraint(equalToConstant: 48),
            
            saveButton.topAnchor.constraint(equalTo: hStackView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    private func setupInitialPickerDate() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        monthYearPicker.selectRow(currentMonth - 1, inComponent: 0, animated: false)
    }
}

extension NewBudgetSectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Define 2 colunas: Mês e Ano
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Define quantas linhas cada coluna terá
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? months.count : years.count
    }
    
    // Define o texto de cada linha
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? months[row] : "\(years[row])"
    }
    
    // Atualiza o TextField quando a roleta gira
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTextFieldWithSelectedDate()
    }
}
