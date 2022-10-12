//
//  MainPresenterDataSource.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 30.09.2022.
//

import UIKit

final class MainPresenterDataSource: NSObject, UICollectionViewDataSource {
    
    weak var delegate: MainDataSourceDelegate?
    
    private var imageStore = [URL: UIImage]()
    
    private var selectCategoryCells = [
        SelectCategoryCellViewModel(image: UIImage(named: "Phones"), category: "Phones"),
        SelectCategoryCellViewModel(image: UIImage(named: "Computer"), category: "Computer"),
        SelectCategoryCellViewModel(image: UIImage(named: "Health"), category: "Health"),
        SelectCategoryCellViewModel(image: UIImage(named: "Books"), category: "Books")
    ]
    var hotSalesCells = [HotSalesCellViewModel]()
    var bestSellerCells = [BestSellerCellViewModel]()
        
    private func requestImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = self.imageStore[url] {
            completion(image)
        } else {
            self.delegate?.requestImage(with: url) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let imageData):
                        let image = UIImage(data: imageData)
                        self?.imageStore[url] = image
                        completion(image)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .selectCategory:
            return selectCategoryCells.count
        case .hotSales:
            return hotSalesCells.count
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
        case .selectCategory:
            let cell: SelectCategoryViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = selectCategoryCells[indexPath.item]
            cell.configure(with: model)
            
            return cell
            
        case .hotSales:
            let cell: HotSalesViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = hotSalesCells[indexPath.item]
            cell.configure(with: model)
            requestImage(with: model.imageUrl) { image in
                cell.addProductImage(image: image)
            }
            return cell
            
        case .bestSeller:
            let cell: BestSellerViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let model = bestSellerCells[indexPath.item]
            cell.configure(with: model)
            requestImage(with: model.imageUrl) { image in
                cell.addProductImage(image: image)
            }
            return cell
            
        case .searchBar:
            let cell: SearchBarViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}
