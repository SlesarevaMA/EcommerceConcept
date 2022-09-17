//
//  HotSales.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import Foundation

struct HotSales: Codable {
    let id: Int
    let isNew: Bool
    let title: String
    let subtitle: String
    let picture: String
    let isBuy: Bool
}

struct HotSalesResponse: Codable {
    let homeStore: [HotSales]
}

extension HotSales {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        picture = try container.decode(String.self, forKey: .picture)
        isBuy = try container.decode(Bool.self, forKey: .isBuy)
    }
}
