//
//  UIColor+extension.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 22.08.2022.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
}
