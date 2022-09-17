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
    static let buttonSide: CGFloat = 71
    
    static let categoryLabelFont: UIFont = .systemFont(ofSize: 12)
    
    static let defaultColor: UIColor = .init(hex: 0xB3B3C3)
    static let isSelectedColor: UIColor = .init(hex: 0xFF6E4E)
    static let whiteColor: UIColor = .init(hex: 0xFFFFFF)
    static let tintColor: UIColor = .init(hex: 0xB3B3C3)
    static let categoryLabelColor: UIColor = .black
}

final class SelectCategoryViewCell: UICollectionViewCell, Identifiable {
    
    private let button = UIButton()
    private let categoryLabel = UILabel()
    
    private var isSelectedCategory = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frame for newLabel
        button.layoutIfNeeded()
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    func configure(with model: SelectCategoryCellViewModel) {
        button.setImage(model.image, for: .normal)
        
        categoryLabel.text = model.category
    }
    
    @objc func selected() {
        if isSelectedCategory {
            button.backgroundColor = Metrics.isSelectedColor
            button.tintColor = Metrics.whiteColor
            categoryLabel.textColor = Metrics.isSelectedColor
            isSelectedCategory = false
        } else {
            button.backgroundColor = Metrics.whiteColor
            button.tintColor = Metrics.tintColor
            categoryLabel.textColor = Metrics.categoryLabelColor
            isSelectedCategory = true
        }
    }
    
    private func configure() {
        addConstrains()
        configureSubviews()
    }
    
    private func addConstrains() {
        [button, categoryLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: Metrics.buttonSide),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: Metrics.verticalSpacing)
        ])
    }
    
    private func configureSubviews() {
        button.backgroundColor = Metrics.whiteColor
        button.tintColor = Metrics.tintColor
        button.addTarget(self, action: #selector(selected), for: .touchUpInside)
//        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        categoryLabel.font = Metrics.categoryLabelFont
        categoryLabel.textAlignment = .center
    }
}
