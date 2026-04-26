//
//  MonthCarouselView.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 07/04/26.
//

import UIKit

final class MonthCarouselView: UIView {
    
    var onMonthChanged: ((Int) -> Void)?
    
    private let months = ["JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ"]
    
    private var selectedIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MonthCell.self, forCellWithReuseIdentifier: MonthCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var leftArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray500
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(leftArrowTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray500
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rightArrowTapped), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.clear
        
        addSubview(leftArrowButton)
        addSubview(collectionView)
        addSubview(rightArrowButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftArrowButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftArrowButton.topAnchor.constraint(equalTo: collectionView.topAnchor),
            leftArrowButton.widthAnchor.constraint(equalToConstant: 16),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 16),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leftArrowButton.trailingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: rightArrowButton.leadingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 22),
            
            rightArrowButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightArrowButton.topAnchor.constraint(equalTo: collectionView.topAnchor),
            rightArrowButton.widthAnchor.constraint(equalToConstant: 16),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    @objc private func leftArrowTapped() {
        guard selectedIndex > 0 else { return }
        let newIndex = selectedIndex - 1
        scrollToItem(at: newIndex)
    }
    
    @objc private func rightArrowTapped() {
        guard selectedIndex < months.count - 1 else { return }
        let newIndex = selectedIndex + 1
        scrollToItem(at: newIndex)
    }
    
    func scrollToItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        selectedIndex = index
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let collectionWidth = layoutEnvironment.container.effectiveContentSize.width
            let itemWidth = collectionWidth * 0.2
            let horizontalInset = (collectionWidth - itemWidth) / 2.0
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth),
                                                   heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                            leading: horizontalInset,
                                                            bottom: 0,
                                                            trailing: horizontalInset)
            
            return section
        }
    }
}

extension MonthCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCell.identifier, for: indexPath) as? MonthCell else {
            return UICollectionViewCell()
        }
        
        let monthString = months[indexPath.item]
        let isSelected = indexPath.item == selectedIndex
        cell.configure(with: monthString, isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMonthIndex = indexPath.item
        scrollToItem(at: selectedMonthIndex)
        onMonthChanged?(selectedMonthIndex)
    }
}
