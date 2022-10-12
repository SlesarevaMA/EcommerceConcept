//
//  CoreAssembly.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 05.10.2022.
//

import Foundation

final class CoreAssembly {
    static let networkManager: NetworkManager = NetworkManagerImpl()
    static let homeStoreDecoder: JSONDecoder = HomeStoreJSONDecoder()
}
