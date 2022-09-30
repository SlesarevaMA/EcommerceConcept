//
//  SearchBarViewCell.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 25.09.2022.
//

import UIKit

private enum Metrics {
    static let horizontalSpacing: CGFloat = 11
    static let qrCodeButtonWidth: CGFloat = 34
    
    static let searchBarFont: UIFont = .systemFont(ofSize: 12)
    
    static let qrCodeColor: UIColor = .white
    static let searchBarBackgroundColor: UIColor = .white
    static let searchBarTextColor: UIColor = .init(hex: 0x010035).withAlphaComponent(0.5)
    static let baseColor: UIColor = .init(hex: 0xFF6E4E)
}

final class SearchBarViewCell: UICollectionViewCell, Identifiable {

    private let searchView = UISearchBar()
    private let qrCodeButton = UIButton()
    
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
        qrCodeButton.layoutIfNeeded()
        searchView.layoutIfNeeded()
        
        qrCodeButton.layer.cornerRadius = qrCodeButton.frame.height / 2
        searchView.layer.cornerRadius = searchView.frame.height / 2
        
        searchView.clipsToBounds = true
    }
    
    private func configure() {
        addConstrains()
        configureSubviews()
    }
    
    private func addConstrains() {
        [searchView, qrCodeButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            qrCodeButton.widthAnchor.constraint(equalToConstant: Metrics.qrCodeButtonWidth),
            qrCodeButton.widthAnchor.constraint(equalTo: qrCodeButton.heightAnchor),
            qrCodeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            qrCodeButton.leadingAnchor.constraint(
                equalTo: searchView.trailingAnchor,
                constant: Metrics.horizontalSpacing
            ),
            qrCodeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            qrCodeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureSubviews() {
        searchView.setImage(UIImage(named: "loupe"), for: .search, state: .normal)
        searchView.searchTextField.textColor = Metrics.searchBarTextColor
        searchView.searchTextField.font = Metrics.searchBarFont
        searchView.placeholder = "Search"
        searchView.searchTextField.backgroundColor = .white
        searchView.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        
        qrCodeButton.tintColor = Metrics.qrCodeColor
        qrCodeButton.backgroundColor = Metrics.baseColor
        qrCodeButton.setImage(UIImage(named: "QR-code"), for: .normal)
    }
}
