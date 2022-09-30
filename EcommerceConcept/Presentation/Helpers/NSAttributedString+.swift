//
//  NSAttributedString+.swift
//  EcommerceConcept
//
//  Created by Margarita Slesareva on 20.09.2022.
//

import Foundation

extension NSAttributedString {
    
    func withStrikeThrough() -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(
            .strikethroughStyle,
            value: 1,
            range: NSRange(location: 0, length: string.count)
        )
        
        return NSAttributedString(attributedString: attributedString)
    }
}
