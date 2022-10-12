//
//  MainPresenter.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 03.10.2022.
//

import UIKit

protocol MainPresenter: AnyObject {
    func viewDidLoad()
}

final class MainPresenterImpl: MainPresenter {
    
    private weak var view: MainView?
    private let dataSource: MainPresenterDataSource
    private let requestImageService: RequestImageService
    private let hotSalesService: HotSalesService
    private let bestSellerService: BestSellerService
    
    init(
        view: MainView,
        dataSourse: MainPresenterDataSource,
        requestImageService: RequestImageService,
        hotSalesService: HotSalesService,
        bestSellerService: BestSellerService
    ) {
        self.view = view
        self.dataSource = dataSourse
        self.requestImageService = requestImageService
        self.hotSalesService = hotSalesService
        self.bestSellerService = bestSellerService
    }
    
    // MARK: MainPresenter
    
    func viewDidLoad() {
        requestItems()
    }
    
    private func requestItems() {
        hotSalesService.requestInfo { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.dataSource.hotSalesCells = results.map(self.mapHotSalesViewModel)
                    self.view?.reload(.hotSales)
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
                    self.view?.reload(.bestSeller)
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

// MARK: - MainDataSourceDelegate

extension MainPresenterImpl: MainDataSourceDelegate {
    func requestImage(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        requestImageService.requestImage(at: url, completion: completion)
    }
}
