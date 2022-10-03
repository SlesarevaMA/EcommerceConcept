//
//  MainViewController.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

private enum Metrics {
    enum CollectionView {
        static let interitemSpacing: CGFloat = 12
        static let backgroundColor: UIColor = .init(hex: 0xE5E5E5)
    }

    enum SelectCategory {
        static let height: CGFloat = 93
        static let horizontalEdgeInsets: CGFloat = 11.5
    }
    
    enum HotSales {
        static let height: CGFloat = 182
        static let leadinghorizontalEdgeInsets: CGFloat = 15
        static let trailinghorizontalEdgeInsets: CGFloat = 21
    }
    
    enum BestSeller {
        static let height: CGFloat = 227
        static let verticalEdgeInsets: CGFloat = 6
        static let horizontalEdgeInsets: CGFloat = 7
    }
    
    enum SearchBar {
        static let height: CGFloat = 34
        static let leadingEdgeInsets: CGFloat = 32
        static let trailingEdgeInsets: CGFloat = 37
    }
}

final class MainViewController: UIViewController {
                
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    }()
    
    private lazy var dataSource = MainViewControllerDataSource(delegate: self)
    
    private let hotSalesService = HotSalesServiceImpl()
    private let bestSellerService = BestSellerServiceImpl()
    private let requestImageService = RequestImageServiceImpl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        prepareCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestItems()
    }
    
    private func addSubviews() {
        [collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func prepareCollectionView() {
        collectionView.backgroundColor = Metrics.CollectionView.backgroundColor
        collectionView.dataSource = dataSource
        collectionView.register(cell: SelectCategoryViewCell.self)
        collectionView.register(cell: SearchBarViewCell.self)
        collectionView.register(cell: HotSalesViewCell.self)
        collectionView.register(cell: BestSellerViewCell.self)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = {
            [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard  let self = self, let sectionKind = Section(rawValue: sectionIndex) else {
                return nil
            }
            
            return self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Metrics.CollectionView.interitemSpacing
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
    }
    
    private func sectionProvider(
        sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        guard let sectionKind = Section(rawValue: sectionIndex) else {
            return nil
        }
        
        return layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
    }
    
    private func layoutSection(
        for section: Section,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        switch section {
        case .selectCategory:
            return selectCategorySection()
        case .searchBar:
            return searchBarSection()
        case .hotSales:
            return hotSalesSection()
        case .bestSeller:
            return bestSellerSection()
        }
    }
    
    private func selectCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .estimated(Metrics.SelectCategory.height)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: Metrics.SelectCategory.horizontalEdgeInsets,
            bottom: 0,
            trailing: Metrics.SelectCategory.horizontalEdgeInsets
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func searchBarSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Metrics.SearchBar.height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: Metrics.SearchBar.leadingEdgeInsets,
            bottom: 0,
            trailing: Metrics.SearchBar.trailingEdgeInsets
        )

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    private func hotSalesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Metrics.HotSales.height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: Metrics.HotSales.leadinghorizontalEdgeInsets,
            bottom: 0,
            trailing: Metrics.HotSales.trailinghorizontalEdgeInsets
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
            
    private func bestSellerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Metrics.BestSeller.verticalEdgeInsets,
            leading: Metrics.BestSeller.horizontalEdgeInsets,
            bottom: Metrics.BestSeller.verticalEdgeInsets,
            trailing: Metrics.BestSeller.horizontalEdgeInsets
        )
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Metrics.BestSeller.height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func requestItems() {
        hotSalesService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.dataSource.hotSalesCells = results.map(self.mapHotSalesViewModel)
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        bestSellerService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.dataSource.bestSellerCells = results.map(self.mapBestSellerViewModel)
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func mapHotSalesViewModel(from apiModel: HotSales) -> HotSalesCellViewModel {
        return HotSalesCellViewModel(
            imageUrl: apiModel.picture,
            isNewLabelVisible: apiModel.isNew,
            brand: apiModel.title,
            description: apiModel.subtitle
        )
    }
    
    private func mapBestSellerViewModel(from apiModel: BestSeller) -> BestSellerCellViewModel {
        return BestSellerCellViewModel(
            brand: apiModel.title,
            price: apiModel.priceWithoutDiscount,
            discountPrice: apiModel.discountPrice,
            imageUrl: apiModel.picture
        )
    }
}

extension MainViewController: MainViewControllerDataSourceDelegate {
    func requestImage(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        requestImageService.requestImage(at: url, completion: completion)
    }
}
