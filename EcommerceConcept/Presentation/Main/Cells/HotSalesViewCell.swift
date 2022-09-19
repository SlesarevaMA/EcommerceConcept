//
//  HotSalesViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 21.08.2022.
//

import UIKit

private enum Metrics {
    enum Spacings {
        static let newTop: CGFloat = 14
        static let leading: CGFloat = 25
        static let brandTop: CGFloat = 18
        static let descriptionTop: CGFloat = 5
        static let buyTop: CGFloat = 26
        static let buyTrailing: CGFloat = 17
        static let brandTrailing: CGFloat = 6
        static let minVertical: CGFloat = 8
    }
    
    enum Size {
        static let newLabelWidth: CGFloat = 27
        static let contentViewMultiplier: CGFloat = 0.6
    }
    
    enum Font {
        static let newLabel: UIFont = .systemFont(ofSize: 10)
        static let brandLabel: UIFont = .systemFont(ofSize: 25)
        static let descriptionLabel: UIFont = .systemFont(ofSize: 11)
        static let buyButton: UIFont = .boldSystemFont(ofSize: 11)
    }
    
    enum Text {
        static let newLabel = "New"
        static let buyButton = "Buy now!"
    }
    
    enum Color {
        static let background: UIColor = .black
        static let newLabelText: UIColor = .white
        static let newLabelBackground: UIColor = .init(hex: 0xFF6E4E)
        static let brandLabelText: UIColor = .white
        static let descriptionLabelText: UIColor = .white
        static let buyButtonText: UIColor = .black
        static let buyButtonBackground: UIColor = .white
    }
    
    enum Dimension {
        static let buyButtonCornerRadius: CGFloat = 5
        static let buyButtonContentEdgeInsets: UIEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
    }
}

final class HotSalesViewCell: UICollectionViewCell, Identifiable {
    
    private(set) var imageUrl: URL?
        
    private let newLabel = UILabel()
    private let brandLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let buyButton = UIButton()
    private let productImageView = UIImageView()
    private let containerView = UIView()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set frames for subviews
        newLabel.layoutIfNeeded()
        productImageView.layoutIfNeeded()
        
        newLabel.layer.cornerRadius = newLabel.frame.height / 2
        gradientLayer.frame = productImageView.bounds
    }

    func configure(with model: HotSalesCellViewModel) {
        newLabel.isHidden = !model.isNewLabelVisible
        brandLabel.text = model.brand
        descriptionLabel.text = model.description
        imageUrl = model.imageUrl
    }
    
    func addProductImage(image: UIImage?) {
        productImageView.image = image
    }
    
    private func configure() {
        addConstrains()
        configureSubviews()
    }

    private func addConstrains() {
        [newLabel, brandLabel, descriptionLabel, buyButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [productImageView, containerView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            newLabel.widthAnchor.constraint(equalTo: newLabel.heightAnchor),
            newLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.Spacings.newTop),
            newLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Metrics.Spacings.leading
            ),
            newLabel.widthAnchor.constraint(equalToConstant: Metrics.Size.newLabelWidth),
            
            brandLabel.topAnchor.constraint(
                lessThanOrEqualTo: newLabel.bottomAnchor,
                constant: Metrics.Spacings.brandTop
            ),
            brandLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Metrics.Spacings.leading
            ),
            brandLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Metrics.Spacings.brandTrailing
            ),

            descriptionLabel.topAnchor.constraint(
                equalTo: brandLabel.bottomAnchor,
                constant: Metrics.Spacings.descriptionTop
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Metrics.Spacings.leading
            ),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: brandLabel.trailingAnchor),
            
            buyButton.topAnchor.constraint(
                equalTo: descriptionLabel.bottomAnchor,
                constant: Metrics.Spacings.buyTop
            ),
            buyButton.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Metrics.Spacings.leading
            ),
            buyButton.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -Metrics.Spacings.minVertical
            ),
            
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: Metrics.Size.contentViewMultiplier
            ),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.widthAnchor.constraint(
                lessThanOrEqualTo: contentView.widthAnchor,
                multiplier: Metrics.Size.contentViewMultiplier
            ),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureSubviews() {
        backgroundColor = Metrics.Color.background
        
        newLabel.text = Metrics.Text.newLabel
        newLabel.textColor = Metrics.Color.newLabelText
        newLabel.font = Metrics.Font.newLabel
        newLabel.backgroundColor = Metrics.Color.newLabelBackground
        newLabel.layer.masksToBounds = true
        newLabel.textAlignment = .center
        
        brandLabel.textColor = Metrics.Color.brandLabelText
        brandLabel.font = Metrics.Font.brandLabel
        brandLabel.numberOfLines = 2
        
        descriptionLabel.textColor = Metrics.Color.descriptionLabelText
        descriptionLabel.font = Metrics.Font.descriptionLabel
        
        buyButton.setTitleColor(Metrics.Color.buyButtonText, for: .normal)
        buyButton.setTitle(Metrics.Text.buyButton, for: .normal)
        buyButton.titleLabel?.font = Metrics.Font.buyButton
        buyButton.backgroundColor = Metrics.Color.buyButtonBackground
        buyButton.layer.cornerRadius = Metrics.Dimension.buyButtonCornerRadius
        buyButton.contentEdgeInsets = Metrics.Dimension.buyButtonContentEdgeInsets
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0.5)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.black.withAlphaComponent(0).cgColor]
        productImageView.layer.addSublayer(gradientLayer)
    }
}
