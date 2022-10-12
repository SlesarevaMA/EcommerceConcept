//
//  RequestImageService.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 28.09.2022.
//

import UIKit

protocol RequestImageService {
    func requestImage(at url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class RequestImageServiceImpl: RequestImageService {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func requestImage(at url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let imageRequest = HomeStoreImageRequest(url: url)
        
        networkManager.sendRequest(request: imageRequest) { result in
            completion(result)
        }
    }
}
