//
//  HomeStoreRequest.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

struct HomeStoreRequest {
    
    var urlRequest: URLRequest {
        guard let url = URL(string: "https://run.mocky.io/v3/2253baf9-fe22-47aa-b3f7-3de47f64a5c2")
        else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
