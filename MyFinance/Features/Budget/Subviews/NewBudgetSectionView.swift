//
//  NewBudgetSectionView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 14/04/26.
//

import UIKit

final class NewBudgetSectionView: UIView {
    
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
    
    private lazy var dateTextField = CustomTextField(placeholder: "00/0000", icon: calendarIconImageView)
    
    private lazy var currencyIconImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "brazilian-currency")?.withRenderingMode(.alwaysTemplate))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray600
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var amountTextField = CustomTextField(placeholder: "0,00", icon: currencyIconImageView)
    
    private lazy var saveButton = PrimaryButton(title: "Adicionar")
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
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
}
