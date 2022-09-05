//
//  Identifiable.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 05.09.2022.
//

protocol Identifiable {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
