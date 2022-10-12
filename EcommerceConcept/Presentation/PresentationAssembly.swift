//
//  PresentationAssembly.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 05.10.2022.
//

import UIKit

final class PresenationAssemblyImpl {
        
    func mainScreen() -> UIViewController {
    
        let dataSourse = MainPresenterDataSource()
        let view = MainViewController()
        
        let presenter = MainPresenterImpl(
            view: view,
            dataSourse: dataSourse,
            requestImageService: ServiceAsssembly.requestImageService,
            hotSalesService: ServiceAsssembly.hotSalesService,
            bestSellerService: ServiceAsssembly.bestSellerService
        )
        
        dataSourse.delegate = presenter
        view.setCollectionViewDataSource(dataSourse: dataSourse)
        view.presenter = presenter
            
        return view
    }
}
