//
//  MainViewControllerDataSourceDelegate.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 02.10.2022.
//

import Foundation

protocol MainViewControllerDataSourceDelegate: AnyObject {
    func requestImage(with url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
