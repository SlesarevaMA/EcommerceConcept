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

private enum Section: Int, CaseIterable {
    case selectCategory
    case searchBar
    case hotSales
    case bestSeller
}

final class MainViewController: UIViewController {
                
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    }()
    
    private var imageStore = [URL: UIImage]()
    
    private let hotSalesService = HotSalesServiceImpl()
    private let bestSellerService = BestSellerServiceImpl()
    private let requestImageService = RequestImageServiceImpl()
    
    private var hotSalesCells = [HotSalesCellViewModel]()
    private var bestSellerCells = [BestSellerCellViewModel]()
    private var selectCategoryCells = [
        SelectCategoryCellViewModel(image: UIImage(named: "Phones"), category: "Phones"),
        SelectCategoryCellViewModel(image: UIImage(named: "Computer"), category: "Computer"),
        SelectCategoryCellViewModel(image: UIImage(named: "Health"), category: "Health"),
        SelectCategoryCellViewModel(image: UIImage(named: "Books"), category: "Books")
    ]
    
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
        collectionView.dataSource = self
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
                    self.hotSalesCells = results.map(self.mapHotSalesViewModel)
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
                    self.bestSellerCells = results.map(self.mapBestSellerViewModel)
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

    private func requestImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = imageStore[url] {
            completion(image)
        } else {
            requestImageService.requestImage(at: url) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        let image = UIImage(data: imageData)
                        self?.imageStore[url] = image
                        completion(image)
                    case .failure(let error):
                        print(error)
                        completion(nil)
                    }
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .hotSales:
            return hotSalesCells.count
        case .selectCategory:
            return selectCategoryCells.count
        case .bestSeller:
            return bestSellerCells.count
        case .searchBar:
            return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            assertionFailure("Wrong section \(indexPath.section)")
            return UICollectionViewCell()
        }
        
        switch section {
        case .hotSales:
            let cell: HotSalesViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = hotSalesCells[indexPath.item]
            
            requestImage(with: model.imageUrl) { image in
                cell.addProductImage(image: image)
            }
            
            cell.configure(with: model)
            return cell
            
        case .selectCategory:
            let cell: SelectCategoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = selectCategoryCells[indexPath.item]
            cell.configure(with: model)
            return cell
            
        case .bestSeller:
            let cell: BestSellerViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = bestSellerCells[indexPath.item]
            
            requestImage(with: model.imageUrl) { image in
                cell.addProductImage(image: image)
            }

            cell.configure(with: model)
			return cell
        case .searchBar:
            let cell: SearchBarViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}
