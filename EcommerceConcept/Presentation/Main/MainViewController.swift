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

enum Section: Int {
    case listSelectCategory
    case listHotSales
    case gridBestSeller
    
    func columnCount(for width: CGFloat) -> Int {
        let wideMode = width > 800
        switch self {
        case .listSelectCategory:
            return wideMode ? 5 : 1
        case .listHotSales:
            return wideMode ? 3 : 1
        case .gridBestSeller:
            return wideMode ? 4 : 2
        }
    }
}

final class MainViewController: UIViewController {
    
    private let hotSalesService = HotSalesServiceImpl()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    private var hotSalesCells = [HotSalesCellViewModel]()
    
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
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground

//        collectionViewLayout.itemSize = CGSize(
//            width: view.frame.width,
//            height: Metrics.collectionViewHeight
//        )
//        collectionViewLayout.minimumInteritemSpacing = Metrics.collectionViewInteritemSpacing
//        collectionViewLayout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: HotSalesViewCell.reuseIdentifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else {
                return nil
            }
            
            let columns = sectionKind.columnCount(for: layoutEnvironment.container.effectiveContentSize.width)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(0.2)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: groupHeight
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        
        return layout
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
