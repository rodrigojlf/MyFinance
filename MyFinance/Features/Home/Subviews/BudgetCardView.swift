//
//  BudgetCardView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class BudgetCardView: UIView {
    
    //    var budget: Budget?
//    var budget: Budget? = nil
        let budget: Budget? = Budget(id: UUID().uuidString,
                                    monthYear: "03/2026",
                                    limitAmount: 3000.00,
                                    transactions: [
                                        Transaction(id: UUID().uuidString,
                                                    title: "Mercado",
                                                    date: "02/05/25",
                                                    amount: 450.67,
                                                    type: .expense,
                                                    iconName: "cart"),
                                        Transaction(id: UUID().uuidString,
                                                    title: "Aluguel",
                                                    date: "05/05/25",
                                                    amount: 2024.00,
                                                    type: .expense,
                                                    iconName: "house"),
                                    ])
    let date: String = "03/2026"
    
    var onSettingsTapped: (() -> Void)?
    
    private let gradient: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#0F0F0F").cgColor,
            UIColor(hex: "#2D2D2D").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.011, y: 0.396)
        gradientLayer.endPoint = CGPoint(x: 0.989, y: 0.604)
        return gradientLayer
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = date.monthName
        label.font = .titleSm
        label.textColor = .gray100
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "/ \(date.yearNumber)"
        label.font = .titleXs
        label.textColor = .gray400
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = .gray100
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray600
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var availableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orçamento disponível"
        label.font = .textSm
        label.textColor = .gray400
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ \(budget?.balance.decimalFormatted ?? "0,00")"
        label.font = .titleLg
        label.textColor = .gray100
        return label
    }()
    
    private lazy var defineBudgetButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Definir orçamento", for: .normal)
        btn.setTitleColor(.appMagenta, for: .normal)
        btn.titleLabel?.font = .buttonMd
        btn.backgroundColor = .appMagenta.withAlphaComponent(0.05)
        btn.layer.borderColor = UIColor.appMagenta.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(defineBudgetButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc private func defineBudgetButtonTapped() {
        onSettingsTapped?()
// irá navegar para uma tela específica ou injetar aqui mesmo? Sendo em outra tela, como vai recarregar a view?
    }
    
    private lazy var usedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Usado"
        label.font = .textXs
        label.textColor = .gray400
        return label
    }()
    
    private lazy var amountSpentLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ \(budget?.amountSpent ?? 0.00)"
        label.font = .textSm
        label.textColor = .gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var limitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Limite"
        label.font = .textXs
        label.textColor = .gray300
        label.textAlignment = .right
        return label
    }()
    
    private lazy var limitAmountLabel: UILabel = {
        let label = UILabel()
        label.text = budget != nil ? "R$ \(budget?.limitAmount ?? 0.00)" : "∞"
        label.font = budget != nil ? .textSm : UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .appMagenta
        progress.trackTintColor = .gray600
        progress.progress = Float((budget?.amountSpent ?? 0.0) / (budget?.limitAmount ?? 0.0))
        progress.clipsToBounds = true
        return progress
    }()
        
    init(/*budget: Budget? = nil*/) {
        super.init(frame: .zero)
        //        self.budget = budget
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.insertSublayer(gradient, at: 0)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addSubview(monthLabel)
        addSubview(yearLabel)
        addSubview(settingsButton)
        addSubview(dividerView)
        
        addSubview(availableLabel)
        if budget != nil {
            addSubview(balanceLabel)
        } else {
            addSubview(defineBudgetButton)
        }
        
        addSubview(usedLabel)
        addSubview(amountSpentLabel)
        
        addSubview(limitLabel)
        addSubview(limitAmountLabel)
        
        addSubview(progressBar)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        var constraints: [NSLayoutConstraint] = [
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            yearLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            yearLabel.bottomAnchor.constraint(equalTo: monthLabel.bottomAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 8),
            
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            dividerView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 11),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            availableLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 12),
            availableLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            usedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            amountSpentLabel.topAnchor.constraint(equalTo: usedLabel.bottomAnchor, constant: 8),
            amountSpentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            limitLabel.centerYAnchor.constraint(equalTo: usedLabel.centerYAnchor),
            limitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            limitAmountLabel.bottomAnchor.constraint(equalTo: amountSpentLabel.bottomAnchor),
            limitAmountLabel.heightAnchor.constraint(equalToConstant: 16),
            limitAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressBar.widthAnchor.constraint(equalTo: widthAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: (budget != nil ? 8 : 0))
        ]
        
        if budget != nil {
            constraints.append(contentsOf: [
                balanceLabel.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 4),
                balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                usedLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 20)
            ])
        } else {
            constraints.append(contentsOf: [
                defineBudgetButton.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 8),
                defineBudgetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                defineBudgetButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -48),
                defineBudgetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                defineBudgetButton.heightAnchor.constraint(equalToConstant: 48),
                usedLabel.topAnchor.constraint(equalTo: defineBudgetButton.bottomAnchor, constant: 20)
            ])
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBudget() {
        
    }
}
