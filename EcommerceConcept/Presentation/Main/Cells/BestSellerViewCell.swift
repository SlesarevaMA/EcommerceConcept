//
//  BestSellerViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 19.09.2022.
//

import UIKit

private enum Metrics {
    enum Spacings {
        static let vertical: CGFloat = 5
        static let horizontal: CGFloat = 21
        static let priceHorizontal: CGFloat = 7
        static let buttonTop: CGFloat = 11
        static let buttonTrailing: CGFloat = 15
        static let brandBottom: CGFloat = 15
    }
    
    enum Size {
        static let favoriteButtonWidth: CGFloat = 25
        static let cornerRadius: CGFloat = 10
        static let lowerPriority: UILayoutPriority = .init(249)
        static let favouriteButtonShadowOpacity: Float = 0.5
        static let favouriteButtonShadowRadius: CGFloat = 20
    }
    
    enum Font {
        static let priceLabel: UIFont = .boldSystemFont(ofSize: 16)
        static let discountPriceLabel: UIFont = .boldSystemFont(ofSize: 10)
        static let brandLabel: UIFont = .systemFont(ofSize: 10)
    }
    
    enum Color {
        static let discountPriceLabel: UIColor = .init(hex: 0xCCCCCC)
        static let button: UIColor = .init(hex: 0xFF6E4E)
        static let buttonBackground: UIColor = .white
        static let background: UIColor = .white
        static let favoriteShadow: CGColor = UIColor.black.cgColor
    }
}

final class BestSellerViewCell: UICollectionViewCell, Identifiable {
    
    private(set) var imageUrl: URL?
    
    private let productImageView = UIImageView()
    private let favouriteButton = UIButton()
    private let priceLabel = UILabel()
    private let discountPriceLabel = UILabel()
    private let brandLabel = UILabel()
    
    private var isFavoriteSelected = true
    
    private let moneyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: BestSellerCellViewModel) {
        brandLabel.text = model.brand
        
        let price = moneyFormatter.string(from: NSNumber(value: model.price))
        let discountPrice = moneyFormatter.string(from: NSNumber(value: model.discountPrice))
        if let discountPrice = discountPrice, let price = price {
            priceLabel.text = String(price)
            discountPriceLabel.text = String(discountPrice)
        }

        if let text = discountPriceLabel.text {
            discountPriceLabel.attributedText = NSAttributedString(string: text).withStrikeThrough()
        }
        
        imageUrl = model.imageUrl
    }
    
    func addProductImage(image: UIImage?) {
        productImageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frames for subviews
        favouriteButton.layoutIfNeeded()
        favouriteButton.layer.cornerRadius = favouriteButton.frame.height / 2
    }
    
    private func configure() {
        addConstraints()
        configureSubviews()
    }
    
    private func addConstraints() {
        [productImageView, priceLabel, discountPriceLabel, brandLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        productImageView.addSubview(favouriteButton)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = Metrics.Size.cornerRadius
        
        productImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        favouriteButton.setContentHuggingPriority(Metrics.Size.lowerPriority, for: .horizontal)
        favouriteButton.setContentHuggingPriority(Metrics.Size.lowerPriority, for: .vertical)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(
                equalTo: productImageView.bottomAnchor,
                constant: Metrics.Spacings.vertical
            ),
            priceLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.horizontal
            ),
            
            discountPriceLabel.lastBaselineAnchor.constraint(equalTo: priceLabel.lastBaselineAnchor),
            discountPriceLabel.leadingAnchor.constraint(
                equalTo: priceLabel.trailingAnchor,
                constant: Metrics.Spacings.priceHorizontal
            ),
            
            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Metrics.Spacings.vertical),
            brandLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Metrics.Spacings.horizontal
            ),
            brandLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            brandLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Metrics.Spacings.brandBottom
            ),
            
            favouriteButton.widthAnchor.constraint(equalTo: favouriteButton.heightAnchor),
            favouriteButton.widthAnchor.constraint(equalToConstant: Metrics.Size.favoriteButtonWidth),
            favouriteButton.topAnchor.constraint(
                equalTo: productImageView.topAnchor,
                constant: Metrics.Spacings.buttonTop
            ),
            favouriteButton.trailingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: -Metrics.Spacings.buttonTrailing
            )
        ])
    }
    
    private func configureSubviews() {
        backgroundColor = Metrics.Color.background
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        
        favouriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        favouriteButton.tintColor = Metrics.Color.button
        favouriteButton.backgroundColor = Metrics.Color.buttonBackground
        favouriteButton.addTarget(self, action: #selector(favoriteSelected), for: .touchUpInside)
        favouriteButton.layer.shadowColor = Metrics.Color.favoriteShadow
        favouriteButton.layer.shadowOpacity = Metrics.Size.favouriteButtonShadowOpacity
        favouriteButton.layer.shadowRadius = Metrics.Size.favouriteButtonShadowRadius
        
        priceLabel.font = Metrics.Font.priceLabel
        
        discountPriceLabel.font = Metrics.Font.discountPriceLabel
        discountPriceLabel.textColor = Metrics.Color.discountPriceLabel
            
        brandLabel.font = Metrics.Font.brandLabel
    }
    
    @objc private func favoriteSelected() {
        let imageName = isFavoriteSelected ? "FavoriteFilled" : "Favorite"
        favouriteButton.setImage(UIImage(named: imageName), for: .normal)
        isFavoriteSelected.toggle()
    }
}
