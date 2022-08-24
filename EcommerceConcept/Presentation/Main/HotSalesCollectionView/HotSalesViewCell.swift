//
//  HotSalesViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 21.08.2022.
//

import UIKit

protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

private enum Metrics {
    static let topNewSpacing: CGFloat = 14
    static let leadingSpacing: CGFloat = 25
    static let topBrandSpacing: CGFloat = 18
    static let topDescriptionSpacing: CGFloat = 5
    static let topBuySpacing: CGFloat = 26
}

final class HotSalesViewCell: UICollectionViewCell, Identifiable {
        
    private let newLabel = UILabel()
    private let brandLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let buyButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [newLabel, brandLabel, descriptionLabel, buyButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.topNewSpacing
            ),
            newLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            
            brandLabel.topAnchor.constraint(
                equalTo: newLabel.bottomAnchor,
                constant: Metrics.topBrandSpacing
            ),
            brandLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: brandLabel.bottomAnchor,
                constant: Metrics.topDescriptionSpacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            
            buyButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.topBuySpacing
            ),
            buyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: HotSalesCellViewModel) {
        newLabel.isHidden = model.new
        brandLabel.text = model.brand
        descriptionLabel.text = model.description
    }

    private func configure() {
        newLabel.text = "New"
        newLabel.textColor = .white
        newLabel.font = .systemFont(ofSize: 10)
        newLabel.backgroundColor = UIColor(hex: 0xFF6E4E)
        newLabel.layer.cornerRadius = newLabel.frame.width / 2
        
        brandLabel.textColor = .white
        brandLabel.font = .systemFont(ofSize: 25)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 25)
        
        buyButton.titleLabel?.text = "Buy now!"
        buyButton.titleLabel?.font = .systemFont(ofSize: 11)
        buyButton.backgroundColor = .white
        buyButton.layer.cornerRadius = 20
    }
}
