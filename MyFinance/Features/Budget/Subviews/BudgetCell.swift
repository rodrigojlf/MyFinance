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
    
    var onSwipeThresholdReached: (() -> Void)?
    
    private var panGesture: UIPanGestureRecognizer!
    
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private lazy var pinkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .appMagenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var removerLabel: UILabel = {
        let label = UILabel()
        label.text = "Remover"
        label.font = .buttonSm
        label.textColor = .gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var whiteTrashIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "trash")?.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupView() {
        selectionStyle = .none
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray300.cgColor
        
        contentView.addSubview(pinkBackgroundView)
        pinkBackgroundView.addSubview(removerLabel)
        pinkBackgroundView.addSubview(whiteTrashIconView)
        contentView.addSubview(mainContainerView)
        mainContainerView.addSubview(iconImageView)
        mainContainerView.addSubview(monthLabel)
        mainContainerView.addSubview(yearLabel)
        mainContainerView.addSubview(deleteButton)
        mainContainerView.addSubview(brazilianRealSignLabel)
        mainContainerView.addSubview(amountLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pinkBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            pinkBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pinkBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pinkBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            whiteTrashIconView.centerYAnchor.constraint(equalTo: pinkBackgroundView.centerYAnchor),
            whiteTrashIconView.leadingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: 20),
            whiteTrashIconView.widthAnchor.constraint(equalToConstant: 20),
            whiteTrashIconView.heightAnchor.constraint(equalToConstant: 20),
            
            removerLabel.centerYAnchor.constraint(equalTo: pinkBackgroundView.centerYAnchor),
            removerLabel.leadingAnchor.constraint(equalTo: whiteTrashIconView.trailingAnchor, constant: 8),
            
            mainContainerView.topAnchor.constraint(equalTo: topAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: mainContainerView.centerYAnchor),
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
    
    private func setupGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delegate = self
        mainContainerView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .changed:
            if translation.x < 0 {
                mainContainerView.transform = CGAffineTransform(translationX: translation.x, y: 0)
                whiteTrashIconView.transform = transform
                removerLabel.transform = transform
            }
            
        case .ended, .cancelled:
            let threshold = bounds.width / 3.0
            
            if translation.x < -threshold {
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                                let finalTransform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
                                self.mainContainerView.transform = finalTransform
                                self.whiteTrashIconView.transform = finalTransform
                                self.removerLabel.transform = finalTransform
                            }) { [weak self] _ in
                                self?.onSwipeThresholdReached?()
                            }
                        } else {
                            resetPanPosition(animated: true)
                        }
            
        default:
            break
        }
    }
    
    func resetPanPosition(animated: Bool, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.mainContainerView.transform = .identity
                self.whiteTrashIconView.transform = .identity
                self.removerLabel.transform = .identity
            }) { _ in
                completion?()
            }
        } else {
            self.mainContainerView.transform = .identity
            self.whiteTrashIconView.transform = .identity
            self.removerLabel.transform = .identity
            completion?()
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGesture.velocity(in: self)
            return abs(velocity.x) > abs(velocity.y)
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
