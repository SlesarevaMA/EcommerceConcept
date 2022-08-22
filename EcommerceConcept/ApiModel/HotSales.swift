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
