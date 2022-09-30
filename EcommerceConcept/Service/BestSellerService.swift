//
//  BestSellerService.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 19.09.2022.
//

protocol BestSellerService {
    func requestInfo(completion: @escaping (Result<[BestSeller], Error>) -> Void)
}

final class BestSellerServiceImpl: BestSellerService {
    
    private let networkManager = NetworkManagerImpl()
    private let decoder = HomeStoreJSONDecoder()
    
    func requestInfo(completion: @escaping (Result<[BestSeller], Error>) -> Void) {
        let dataRequest = HomeStoreRequest()
        
        networkManager.sendRequest(request: dataRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let bestSellerResponse = try self.decoder.decode(BestSellerResponse.self, from: data)
                    completion(.success(bestSellerResponse.bestSeller))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
