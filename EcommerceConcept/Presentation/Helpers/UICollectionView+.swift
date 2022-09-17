//
//  UICollectionView+.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 15.09.2022.
//

import UIKit

extension UICollectionView {
    
    func register<T: Identifiable>(cell: T.Type) {
        register(T.self as? AnyClass, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: Identifiable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(T.self) for indexPath: \(indexPath)")
        }
        
        return cell
    }
}
