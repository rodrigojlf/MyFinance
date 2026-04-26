//
//  EmptyTransactionCell.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 26/04/26.
//

import UIKit

final class EmptyTransactionCell: UITableViewCell {
    
    static let identifier = "EmptyTransactionCell"
    
    private lazy var iconImageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "note")?.withRenderingMode(.alwaysTemplate))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray400
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Você ainda não registrou despesas ou receitas neste mês"
        label.font = .textXs
        label.textColor = .gray500
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .gray100
        layer.cornerRadius = 12
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
