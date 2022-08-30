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
    static let trailingBuySpacing: CGFloat = 17
}

final class HotSalesViewCell: UICollectionViewCell, Identifiable {
        
    private let newLabel = UILabel()
    private let brandLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let buyButton = UIButton()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newLabel.layoutIfNeeded()
        newLabel.layer.cornerRadius = newLabel.frame.height / 2
    }

    func configure(with model: HotSalesCellViewModel) {
        newLabel.isHidden = model.isNewLabelVisible
        brandLabel.text = model.brand
        descriptionLabel.text = model.description
        imageView.image = model.image
    }
    
    private func configure() {
        addConstrains()
        configureSubviews()
    }

    private func addConstrains() {
        [newLabel, brandLabel, descriptionLabel, buyButton, imageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            newLabel.widthAnchor.constraint(
                equalTo: newLabel.heightAnchor
            ),
            newLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Metrics.topNewSpacing
            ),
            newLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            newLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            ),
            newLabel.widthAnchor.constraint(
                equalToConstant: 27
            ),
            
            brandLabel.topAnchor.constraint(
                equalTo: newLabel.bottomAnchor,
                constant: Metrics.topBrandSpacing
            ),
            brandLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            brandLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: brandLabel.bottomAnchor,
                constant: Metrics.topDescriptionSpacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            descriptionLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            ),
            
            buyButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.topBuySpacing
            ),
            buyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.leadingSpacing
            ),
            buyButton.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.trailingAnchor
            ),
            
            imageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            imageView.leadingAnchor.constraint(
                equalTo: buyButton.trailingAnchor,
                constant: Metrics.trailingBuySpacing
            ),
            imageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            imageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
    }
    
    private func configureSubviews() {
        self.backgroundColor = .black
        
        newLabel.text = "New"
        newLabel.textColor = .white
        newLabel.font = .systemFont(ofSize: 10)
        newLabel.backgroundColor = UIColor(hex: 0xFF6E4E)
        newLabel.layer.masksToBounds = true
        newLabel.textAlignment = .center
        
        brandLabel.textColor = .white
        brandLabel.font = .systemFont(ofSize: 25)
        
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 25)
        
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.setTitle("Buy now!", for: .normal)
        buyButton.titleLabel?.font = .boldSystemFont(ofSize: 11)
        buyButton.backgroundColor = .white
        buyButton.layer.cornerRadius = 5
        buyButton.contentEdgeInsets = UIEdgeInsets(
            top: 5,
            left: 20,
            bottom: 5,
            right: 20
        )
    }
}
