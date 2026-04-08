//
//  MonthCell.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 08/04/26.
//

import UIKit

final class MonthCell: UICollectionViewCell {
    
    static let identifier = "MonthCell"
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray400
        label.font = .title2Xs
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .appMagenta
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(monthLabel)
        contentView.addSubview(indicatorView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            indicatorView.widthAnchor.constraint(equalTo: monthLabel.widthAnchor, multiplier: 1.2),
            indicatorView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    func configure(with string: String, isSelected: Bool) {
        monthLabel.text = string
        
        if isSelected {
            monthLabel.textColor = .gray700
            monthLabel.font = .titleXs
            indicatorView.isHidden = false
        } else {
            monthLabel.textColor = .gray400
            monthLabel.font = .title2Xs
            indicatorView.isHidden = true
        }
    }
}
