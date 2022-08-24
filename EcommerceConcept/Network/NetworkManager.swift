//
//  NetworkManager.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

protocol NetworkManager {
    func sendRequest(request: HomeStoreRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManagerImpl: NetworkManager {
    func sendRequest(request: HomeStoreRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200, let data = data {
                 completion(.success(data))
             } else {
                 if let error = error {
                     completion(.failure(error))
                 }
            }
        }
        
        dataTask.resume()
    }
}
