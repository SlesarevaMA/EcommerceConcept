//
//  SelectCategoryViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 06.09.2022.
//

import UIKit

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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])

    }
    
    private func configureSubviews() {
        
    }
}
