//
//  MainViewController.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    )
    
    private let hotSalesCells = [
        HotSalesCellViewModel(image: nil,
                              isNewLabelVisible: true,
                              brand: "nokia",
                              description: "gg"),
        HotSalesCellViewModel(image: nil,
                              isNewLabelVisible: false,
                              brand: "iphone",
                              description: "kk"),
    ]

//    private var hotSalesCells = [HotSalesCellViewModel]()
    private var hotSalesModels = [HotSales]()
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
            collectionView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 40
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
        ])
    }
    
    private func prepareCollectionView() {
        collectionViewLayout.itemSize = CGSize(
            width: view.frame.width,
            height: view.frame.height / 4
        )
        collectionViewLayout.minimumInteritemSpacing = 12
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(
            HotSalesViewCell.self,
            forCellWithReuseIdentifier: HotSalesViewCell.reuseIdentifier)
    }
    
    private func requestItems() {
        hotSalesService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.hotSalesModels = results
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesViewCell.reuseIdentifier, for: indexPath) as? HotSalesViewCell
        else {
            fatalError("Unable to dequeue RocketParametersViewCell")
        }
        
        let model = hotSalesCells[indexPath.item]
        cell.configure(with: model)

        return cell
    }
}
