//
//  HomeStoreRequest.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

struct HomeStoreRequest {
    
    var urlRequest: URLRequest {
        guard let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
        else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
