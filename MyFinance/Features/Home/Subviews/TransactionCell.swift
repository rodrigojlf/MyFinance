//
//  TransactionCell.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

final class TransactionCell: UITableViewCell {
    
    static let identifier = "TransactionCell"
    
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray300.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .appMagenta
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .titleSm
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .textXs
        label.textColor = .gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .textXs
        label.textColor = .gray700
        label.text = "R$"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .titleSm
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowIconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var deleteIconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .gray100
        layer.borderColor = UIColor.gray200.cgColor
        layer.borderWidth = 1
        
        addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(currencyLabel)
        addSubview(amountLabel)
        addSubview(arrowIconImageView)
        addSubview(deleteIconImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconContainerView.widthAnchor.constraint(equalToConstant: 32),
            iconContainerView.heightAnchor.constraint(equalToConstant: 32),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 12),
            dateLabel.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor),
            
            deleteIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            deleteIconImageView.widthAnchor.constraint(equalToConstant: 16),
            deleteIconImageView.heightAnchor.constraint(equalToConstant: 16),
            deleteIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowIconImageView.trailingAnchor.constraint(equalTo: deleteIconImageView.leadingAnchor, constant: -12),
            arrowIconImageView.widthAnchor.constraint(equalToConstant: 14),
            arrowIconImageView.heightAnchor.constraint(equalToConstant: 14),
            arrowIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: arrowIconImageView.leadingAnchor, constant: -4),
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            
            currencyLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -4),
            currencyLabel.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor),
        ])
    }
    
    func configure(with transaction: Transaction) {
        iconImageView.image = UIImage(named: transaction.iconName)
        titleLabel.text = transaction.title
        dateLabel.text = transaction.date
        amountLabel.text = transaction.amount.decimalFormatted
        arrowIconImageView.image = UIImage(named: "caret-\(transaction.type == .income ? "up" : "down")-fill")
        deleteIconImageView.image = UIImage(named: "trash")
    }
}
