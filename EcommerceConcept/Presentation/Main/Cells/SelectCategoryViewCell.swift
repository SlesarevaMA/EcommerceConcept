//
//  SelectCategoryViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 06.09.2022.
//

import UIKit

private enum Metrics {
    static let categoryLabelIndent: CGFloat = 8
    static let verticalSpacing: CGFloat = 7
    
    static let categoryLabelFont: UIFont = .systemFont(ofSize: 12)
    
    static let isSelectedColor: UIColor = .init(hex: 0xFF6E4E)
}

final class SelectCategoryViewCell: UICollectionViewCell, Identifiable {
    
    private let imageView = UIImageView()
    private let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SelectCategoryCellViewModel) {
        imageView.image = model.image
        categoryLabel.text = model.category
    }
    
    func isSelected() {
        imageView.backgroundColor = Metrics.isSelectedColor
        categoryLabel.textColor = Metrics.isSelectedColor
    }
    
    private func configure() {
        addConstrains()
        configureSubviews()
    }
    
    private func addConstrains() {
        [imageView, categoryLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            categoryLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.categoryLabelIndent
            ),
            categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metrics.verticalSpacing)
        ])
    }
    
    private func configureSubviews() {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        
        categoryLabel.font = Metrics.categoryLabelFont
        categoryLabel.textAlignment = .center
    }
}
