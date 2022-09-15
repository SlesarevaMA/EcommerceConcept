//
//  MainViewController.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

private enum Metrics {
    static let collectionViewHeight: CGFloat = 182
    static let collectionViewInteritemSpacing: CGFloat = 12
    
    static let selectCategoryWidth: CGFloat = 71
    static let selectCategoryHeight: CGFloat = 93
}

private enum Section: Int, CaseIterable {
    case selectCategory
    case hotSales
}

final class MainViewController: UIViewController {
    
    private let hotSalesService = HotSalesServiceImpl()
    
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    }()
    
    private var hotSalesCells = [HotSalesCellViewModel]()
    
    private var selectCategoryCells = [
        SelectCategoryCellViewModel(image: UIImage(named: "Phones"), category: "Phones"),
        SelectCategoryCellViewModel(image: UIImage(named: "Computer"), category: "Computer"),
        SelectCategoryCellViewModel(image: UIImage(named: "Health"), category: "Health"),
        SelectCategoryCellViewModel(image: UIImage(named: "Books"), category: "Books"),
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func prepareCollectionView() {
        collectionView.backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.registerCell(cell: HotSalesViewCell.self)
        collectionView.registerCell(cell: SelectCategoryViewCell.self)
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
        config.interSectionSpacing = Metrics.collectionViewInteritemSpacing
        
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
        case .hotSales:
            return hotSalesSection()
        case .selectCategory:
            return selectCategorySection()
        }
    }
    
    private func hotSalesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(Metrics.collectionViewHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func selectCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(Metrics.selectCategoryWidth),
            heightDimension: .absolute(Metrics.selectCategoryHeight)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
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
    }
    
    private func mapHotSalesViewModel(from apiModel: HotSales) -> HotSalesCellViewModel {
        return HotSalesCellViewModel(
            image: nil,
            isNewLabelVisible: apiModel.isNew,
            brand: apiModel.title,
            description: apiModel.subtitle
        )
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            assertionFailure("Wrong section \(indexPath.section)")
            return UICollectionViewCell()
        }
        
        switch section {
        case .hotSales:
            let cell: HotSalesViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = hotSalesCells[indexPath.item]
            cell.configure(with: model)
            return cell

        case .selectCategory:
            let cell: SelectCategoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = selectCategoryCells[indexPath.item]
            cell.configure(with: model)
            return cell
        }
    }
}
