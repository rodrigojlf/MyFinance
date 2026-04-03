//
//  BudgetCardView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class BudgetCardView: UIView {
    
    var onSettingsTapped: (() -> Void)?
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MAIO / 2025"
        label.font = .titleXs
        label.textColor = .white
        return label
    }()
    
    private lazy var availableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orçamento disponível"
        label.font = .textSm
        label.textColor = .gray300
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .titleLg
        label.textColor = .white
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = .appMagenta
        progress.trackTintColor = .gray600
        progress.layer.cornerRadius = 4
        progress.clipsToBounds = true
        return progress
    }()
    
    private lazy var usedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .textXs
        label.textColor = .gray300
        return label
    }()
    
    private lazy var limitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .textXs
        label.textColor = .gray300
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray700
        layer.cornerRadius = 16
        
        addSubview(monthLabel)
        addSubview(availableLabel)
        addSubview(amountLabel)
        addSubview(progressBar)
        addSubview(usedLabel)
        addSubview(limitLabel)
        addSubview(settingsButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            availableLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 24),
            availableLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            amountLabel.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            progressBar.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 24),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            
            usedLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            usedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            usedLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            
            limitLabel.centerYAnchor.constraint(equalTo: usedLabel.centerYAnchor),
            limitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    func setup(amount: String, used: String, limit: String, progress: Float) {
        amountLabel.text = amount
        usedLabel.text = "Usado \(used)"
        limitLabel.text = "Limite \(limit)"
        progressBar.progress = progress
    }
}
