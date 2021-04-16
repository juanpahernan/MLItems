//
//  NSNumber+Formatting.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import Foundation

extension NSNumber {
    
    func toCurrency() -> String {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US_POSIX")
        nf.numberStyle = .currency
        return nf.string(from: self) ?? "$ 0.00"
    }
}
