//
//  BudgetCell.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 02/04/26.
//

import UIKit

final class BudgetCell: UITableViewCell {
    
    static let identifier = "BudgetCell"
    
    var onDeleteTapped: (() -> Void)?
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "calendar")
        imageView.tintColor = .gray700
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.font = .titleSm
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .textXs
        label.textColor = .gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.tintColor = .appMagenta
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func deleteAction() {
        print("tocou no botao")
        onDeleteTapped?()
    }
    
    private lazy var brazilianRealSignLabel: UILabel = {
        let label = UILabel()
        label.text = "R$"
        label.font = .textXs
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .titleMd
        label.textColor = .gray700
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .gray100
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray300.cgColor
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(monthLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(deleteButton)
        contentView.addSubview(brazilianRealSignLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            monthLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            monthLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            yearLabel.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 6),
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 16),
            deleteButton.heightAnchor.constraint(equalToConstant: 16),
            
            amountLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -12),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            brazilianRealSignLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -4),
            brazilianRealSignLabel.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor),
        ])
    }
    
    func configure(with budget: Budget) {
        monthLabel.text = budget.wrappedMonth.capitalized
        yearLabel.text = budget.wrappedYear
        amountLabel.text = budget.limitAmount.decimalFormatted
    }
}
