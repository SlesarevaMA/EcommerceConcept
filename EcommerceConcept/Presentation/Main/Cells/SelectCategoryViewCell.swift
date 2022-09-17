//
//  SelectCategoryViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 06.09.2022.
//

import UIKit

private enum Metrics {
    static let verticalSpacing: CGFloat = 7
    static let categoryButtonWidth: CGFloat = 71
    
    static let categoryLabelFont: UIFont = .systemFont(ofSize: 12)
    
    static let selectedColor: UIColor = .init(hex: 0xFF6E4E)
    static let whiteColor: UIColor = .init(hex: 0xFFFFFF)
    static let tintColor: UIColor = .init(hex: 0xB3B3C3)
    static let categoryLabelColor: UIColor = .init(hex: 0x010035)
}

final class SelectCategoryViewCell: UICollectionViewCell, Identifiable {
    
    private let categoryButton = UIButton()
    private let categoryLabel = UILabel()
    
    private var isCategorySelected = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frame for newLabel
        categoryButton.layoutIfNeeded()
        categoryButton.layer.cornerRadius = categoryButton.frame.height / 2
    }
    
    func configure(with model: SelectCategoryCellViewModel) {
        categoryButton.setImage(model.image, for: .normal)
        
        categoryLabel.text = model.category
    }
        
    private func setup() {
        addConstrains()
        configureSubviews()
    }
    
    private func addConstrains() {
        [categoryButton, categoryLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            categoryButton.widthAnchor.constraint(equalToConstant: Metrics.categoryButtonWidth),
            categoryButton.widthAnchor.constraint(equalTo: categoryButton.heightAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: categoryButton.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: Metrics.verticalSpacing)
        ])
    }
    
    private func configureSubviews() {
        categoryButton.backgroundColor = Metrics.whiteColor
        categoryButton.tintColor = Metrics.tintColor
        categoryButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        
        categoryLabel.font = Metrics.categoryLabelFont
        categoryLabel.textColor = Metrics.categoryLabelColor
        categoryLabel.textAlignment = .center
    }
    
    @objc private func selected() {
        if isCategorySelected {
            categoryButton.backgroundColor = Metrics.selectedColor
            categoryButton.tintColor = Metrics.whiteColor
            categoryLabel.textColor = Metrics.selectedColor
            isCategorySelected = false
        } else {
            categoryButton.backgroundColor = Metrics.whiteColor
            categoryButton.tintColor = Metrics.tintColor
            categoryLabel.textColor = Metrics.categoryLabelColor
            isCategorySelected = true
        }
    }
}
