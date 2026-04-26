//
//  BudgetCardView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class BudgetCardView: UIView {
    
    private var budget: Budget?
    private var date: String = ""
    
    var onSettingsTapped: (() -> Void)?
    
    private var withBudgetConstraints: [NSLayoutConstraint] = []
    private var withoutBudgetConstraints: [NSLayoutConstraint] = []
    private var progressBarHeightConstraint: NSLayoutConstraint?
    
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
        label.font = .titleSm
        label.textColor = .gray100
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
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
        addSubview(balanceLabel)
        addSubview(defineBudgetButton)
        addSubview(usedLabel)
        addSubview(amountSpentLabel)
        addSubview(limitLabel)
        addSubview(limitAmountLabel)
        addSubview(progressBar)
        
        balanceLabel.isHidden = true
        defineBudgetButton.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
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
            progressBar.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        progressBarHeightConstraint = progressBar.heightAnchor.constraint(equalToConstant: 0)
        progressBarHeightConstraint?.isActive = true
        
        withBudgetConstraints = [
            balanceLabel.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 4),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            usedLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 20)
        ]
        
        withoutBudgetConstraints = [
            defineBudgetButton.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 8),
            defineBudgetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            defineBudgetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            defineBudgetButton.heightAnchor.constraint(equalToConstant: 48),
            usedLabel.topAnchor.constraint(equalTo: defineBudgetButton.bottomAnchor, constant: 20)
        ]
    }
    
    func setupBudget(budget: Budget?, for monthYear: String) {
        self.budget = budget
        self.date = monthYear
        
        monthLabel.text = date.monthName
        yearLabel.text = "/ \(date.yearNumber)"
        
        if let currentBudget = budget {
            balanceLabel.text = "R$ \(currentBudget.balance.decimalFormatted)"
            amountSpentLabel.text = "R$ \(currentBudget.amountSpent.decimalFormatted)" // Formate se precisar
            limitAmountLabel.text = "R$ \(currentBudget.limitAmount.decimalFormatted)"
            limitAmountLabel.font = .textSm
            
            progressBar.progress = Float(currentBudget.amountSpent / currentBudget.limitAmount)
            progressBarHeightConstraint?.constant = 8
            
            balanceLabel.isHidden = false
            defineBudgetButton.isHidden = true
            
            NSLayoutConstraint.deactivate(withoutBudgetConstraints)
            NSLayoutConstraint.activate(withBudgetConstraints)
            
        } else {
            amountSpentLabel.text = "R$ 0,00"
            limitAmountLabel.text = "∞"
            limitAmountLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
            
            progressBar.progress = 0
            progressBarHeightConstraint?.constant = 0
            
            balanceLabel.isHidden = true
            defineBudgetButton.isHidden = false
            
            NSLayoutConstraint.deactivate(withBudgetConstraints)
            NSLayoutConstraint.activate(withoutBudgetConstraints)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
