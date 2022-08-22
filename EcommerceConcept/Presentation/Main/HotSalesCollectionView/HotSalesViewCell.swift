//
//  HotSalesViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 21.08.2022.
//

import UIKit

private enum Metrics {
    static let topNewSpacing: CGFloat = 14
    static let leftHorizontalSpacing: CGFloat = 25
    static let topBrandSpacing: CGFloat = 18
    static let topDescriptionSpacing: CGFloat = 5
    static let topBuySpacing: CGFloat = 26

}

final class HotSalesViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HotSalesViewCell"
    
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
                constant: Metrics.leftHorizontalSpacing
            ),
            
            brandLabel.topAnchor.constraint(
                equalTo: newLabel.bottomAnchor,
                constant: Metrics.topBrandSpacing
            ),
            brandLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leftHorizontalSpacing
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: brandLabel.bottomAnchor,
                constant: Metrics.topDescriptionSpacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leftHorizontalSpacing
            ),
            
            buyButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.topBuySpacing
            ),
            buyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leftHorizontalSpacing
            ),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: HotSalesCellViewModel) {
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
