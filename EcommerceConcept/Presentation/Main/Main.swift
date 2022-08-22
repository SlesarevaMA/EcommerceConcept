//
//  Main.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.08.2022.
//

import UIKit

final class Main: UIViewController {
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    private var items = [HotSalesCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        prepareCollectionView()
    }
    
    private func addSubviews() {
        [collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func prepareCollectionView() {
        collectionViewLayout.itemSize = CGSize(
            width: view.frame.width - 40, height: view.frame.height / 4
        )
        collectionViewLayout.minimumInteritemSpacing = 12
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.dataSource = self
        collectionView.register(HotSalesViewCell.self, forCellWithReuseIdentifier: "HotSalesViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension Main: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotSalesViewCell", for: indexPath) as? HotSalesViewCell else {
            fatalError("Unable to dequeue RocketParametersViewCell")
        }
        
        let item = items[indexPath.item]
        cell.configureCell(with: item)
        
        return cell
    }
}
