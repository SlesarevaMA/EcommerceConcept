//
//  Imagefiable.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 28.09.2022.
//

import UIKit

protocol Imagefiable {
    
    var imageUrl: URL? { get }

    func addProductImage(image: UIImage?)
}
