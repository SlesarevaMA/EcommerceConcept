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
    
    func requestInfo(completion: @escaping (Result<[HotSales], Error>) -> Void) {
        let dataRequest = HomeStoreRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let hotSalesResponse = try self.decoder.decode(HotSalesResponse.self, from: data)
                    completion(.success(hotSalesResponse.homeStore))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
