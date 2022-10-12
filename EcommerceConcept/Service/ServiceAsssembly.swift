//
//  ServiceAsssembly.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 05.10.2022.
//

import Foundation

final class ServiceAsssembly {
    static let hotSalesService: HotSalesService = HotSalesServiceImpl(
        networkManager: CoreAssembly.networkManager,
        decoder: CoreAssembly.homeStoreDecoder
    )
    
    static let bestSellerService: BestSellerService = BestSellerServiceImpl(
        networkManager: CoreAssembly.networkManager,
        decoder: CoreAssembly.homeStoreDecoder
    )
    
    static let requestImageService: RequestImageService = RequestImageServiceImpl(
        networkManager: CoreAssembly.networkManager
    )
}
