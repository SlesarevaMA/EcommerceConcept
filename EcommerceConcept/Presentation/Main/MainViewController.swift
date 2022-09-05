//
//  MainViewController.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

    private var hotSalesCells = [HotSalesCellViewModel]()

    private let hotSalesService = HotSalesServiceImpl()
    
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
        collectionViewLayout.itemSize = CGSize(width: view.frame.width, height: 182)
        collectionViewLayout.minimumInteritemSpacing = 12
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: HotSalesViewCell.reuseIdentifier)
    }
    
    private func requestItems() {
        hotSalesService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    
                    for model in results {
                        self.hotSalesCells.append(
                            HotSalesCellViewModel(
                                image: nil,
                                isNewLabelVisible: model.isNew,
                                brand: model.title,
                                description: model.subtitle
                            )
                        )
                    }
                    
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
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
