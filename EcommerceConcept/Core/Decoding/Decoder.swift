//
//  Decoder.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

final class HotSalesJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
