//
//  HotSalesViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 21.08.2022.
//

import UIKit

private enum Metrics {
    enum Spacings {
        static let topNewSpacing: CGFloat = 14
        static let leadingSpacing: CGFloat = 25
        static let topBrandSpacing: CGFloat = 18
        static let topDescriptionSpacing: CGFloat = 5
        static let topBuySpacing: CGFloat = 26
        static let trailingBuySpacing: CGFloat = 17
    }
    
    enum Size {
        static let newLabelWidth: CGFloat = 27
    }
    
    enum SubviewsParametrs {
        enum Font {
            static let newLabel = UIFont.systemFont(ofSize: 10)
            static let brandLabel = UIFont.systemFont(ofSize: 25)
            static let descriptionLabel = UIFont.systemFont(ofSize: 25)
            static let buyButton = UIFont.boldSystemFont(ofSize: 11)
        }
        
        enum Text {
            static let newLabel = "New"
            static let buyButton = "Buy now!"
        }
        
        enum Color {
            static let background = UIColor.black
            static let newLabelText = UIColor.white
            static let newLabelBackground = UIColor(hex: 0xFF6E4E)
            static let brandLabelText = UIColor.white
            static let descriptionLabelText = UIColor.white
            static let buyButtonText = UIColor.black
            static let buyButtonBackground = UIColor.white
        }
        
        enum Size {
            static let buyButtonCornerRadius: CGFloat = 5
            static let buyButtonContentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        }
        
        enum InstanceProperty {
            static let newLabelLayerMasksToBounds = true
            static let newLabelTextAlignment = NSTextAlignment.center
        }
    }
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
            newLabel.widthAnchor.constraint(equalTo: newLabel.heightAnchor),
            newLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.Spacings.topNewSpacing),
            newLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.leadingSpacing
            ),
            newLabel.widthAnchor.constraint(equalToConstant: Metrics.Size.newLabelWidth),
            
            brandLabel.topAnchor.constraint(equalTo: newLabel.bottomAnchor, constant: Metrics.Spacings.topBrandSpacing),
            brandLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.leadingSpacing
            ),
            brandLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: brandLabel.bottomAnchor,
                constant: Metrics.Spacings.topDescriptionSpacing
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.leadingSpacing
            ),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            buyButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.Spacings.topBuySpacing
            ),
            buyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.leadingSpacing
            ),
            buyButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(
                equalTo: buyButton.trailingAnchor,
                constant: Metrics.Spacings.trailingBuySpacing
            ),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureSubviews() {
        self.backgroundColor = Metrics.SubviewsParametrs.Color.background
        
        newLabel.text = Metrics.SubviewsParametrs.Text.newLabel
        newLabel.textColor = Metrics.SubviewsParametrs.Color.newLabelText
        newLabel.font = Metrics.SubviewsParametrs.Font.newLabel
        newLabel.backgroundColor = Metrics.SubviewsParametrs.Color.newLabelBackground
        newLabel.layer.masksToBounds = Metrics.SubviewsParametrs.InstanceProperty.newLabelLayerMasksToBounds
        newLabel.textAlignment = Metrics.SubviewsParametrs.InstanceProperty.newLabelTextAlignment
        
        brandLabel.textColor = Metrics.SubviewsParametrs.Color.brandLabelText
        brandLabel.font = Metrics.SubviewsParametrs.Font.brandLabel
        
        descriptionLabel.textColor = Metrics.SubviewsParametrs.Color.descriptionLabelText
        descriptionLabel.font = Metrics.SubviewsParametrs.Font.descriptionLabel
        
        buyButton.setTitleColor(Metrics.SubviewsParametrs.Color.buyButtonText, for: .normal)
        buyButton.setTitle(Metrics.SubviewsParametrs.Text.buyButton, for: .normal)
        buyButton.titleLabel?.font = Metrics.SubviewsParametrs.Font.buyButton
        buyButton.backgroundColor = Metrics.SubviewsParametrs.Color.buyButtonBackground
        buyButton.layer.cornerRadius = Metrics.SubviewsParametrs.Size.buyButtonCornerRadius
        buyButton.contentEdgeInsets = Metrics.SubviewsParametrs.Size.buyButtonContentEdgeInsets
    }
}
