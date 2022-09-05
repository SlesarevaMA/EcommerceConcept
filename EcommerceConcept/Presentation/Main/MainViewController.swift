//
//  MainViewController.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

private enum MetricsMainViewController {
    static let collectionViewHeight: CGFloat = 182
    static let collectionViewInteritemSpacing: CGFloat = 12
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
        collectionViewLayout.itemSize = CGSize(
            width: view.frame.width,
            height: MetricsMainViewController.collectionViewHeight
        )
        collectionViewLayout.minimumInteritemSpacing = MetricsMainViewController.collectionViewInteritemSpacing
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: HotSalesViewCell.reuseIdentifier)
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
