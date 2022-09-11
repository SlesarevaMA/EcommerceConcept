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
}

private enum Section: Int {
    case hotSales
}

final class MainViewController: UIViewController {
    
    private let hotSalesService = HotSalesServiceImpl()
    
    private lazy var collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    }()
    
    private var hotSalesCells = [HotSalesCellViewModel]()
    
    private var selectCategoryCellStore = [ "Phones": UIImage(named: "Phones"),
                                            "Computer": UIImage(named: "Computer"),
                                            "Health": UIImage(named: "Health"),
                                            "Books": UIImage(named: "Books")
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
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: HotSalesViewCell.reuseIdentifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Metrics.collectionViewInteritemSpacing
        
        return  UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
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

    private func requestItems() {
        hotSalesService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.hotSalesCells = self.getViewModels(from: results)
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getViewModels(from apiModels: [HotSales]) -> [HotSalesCellViewModel] {
        var hotSalesCells = [HotSalesCellViewModel]()
                
        for model in apiModels {
            let cell = HotSalesCellViewModel(
                image: nil,
                isNewLabelVisible: model.isNew,
                brand: model.title,
                description: model.subtitle
            )
            
            hotSalesCells.append(cell)
        }
        
        return hotSalesCells
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotSalesCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HotSalesViewCell.reuseIdentifier,
            for: indexPath
        ) as? HotSalesViewCell
        else {
            fatalError("Unable to dequeue RocketParametersViewCell")
        }

        let model = hotSalesCells[indexPath.item]
        cell.configure(with: model)

        return cell
    }
}
