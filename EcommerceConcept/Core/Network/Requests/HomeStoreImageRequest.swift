//
//  HomeStoreImageRequest.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 08.09.2022.
//

import Foundation

struct HomeStoreImageRequest: Request {
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
}
