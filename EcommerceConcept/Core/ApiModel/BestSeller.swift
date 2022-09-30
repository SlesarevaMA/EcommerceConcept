//
//  BestSeller.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 19.09.2022.
//

import Foundation

struct BestSeller: Codable {
    let id: Int
    let isFavorites: Bool
    let title: String
    let priceWithoutDiscount: Int
    let discountPrice: Int
    let picture: URL
}

struct BestSellerResponse: Codable {
    let bestSeller: [BestSeller]
}
