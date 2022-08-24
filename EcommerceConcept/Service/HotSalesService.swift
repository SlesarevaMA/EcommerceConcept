//
//  HotSalesService.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

protocol HotSalesService {
    func requestInfo(completion: @escaping (Result<[HotSales], Error>) -> Void)
}

final class HotSalesServiceImpl: HotSalesService {
   
    private let networkManager = NetworkManagerImpl()
    private let decoder = HotSalesJSONDecoder()
    
//    init(networkManager: NetworkManager, decoder: JSONDecoder) {
//        self.networkManager = networkManager
//        self.decoder = decoder
//    }
    
    func requestInfo(completion: @escaping (Result<[HotSales], Error>) -> Void) {
        let dataRequest = HomeStoreRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                if let hotSales = try? self.decoder.decode([HotSales].self, from: data) {
                    completion(.success(hotSales))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
