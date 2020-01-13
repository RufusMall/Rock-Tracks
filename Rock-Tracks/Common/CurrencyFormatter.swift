//
//  CurrencyFormatter.swift
//  Rock-Tracks
//
//  Created by Rufus on 11/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class CurrencyFormatter {
    let formatter: NumberFormatter
    init () {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.formatter = formatter
    }
    
    /// format value as currency
    /// - Parameters:
    ///   - currencyCode: ISO 4217 standard currency code
    ///   - amount: amount. This is in the currency specified by currencyCode
    func format(currencyCode: String, amount: Double) -> String? {
        formatter.currencyCode = currencyCode
        return formatter.string(from: NSNumber(value: amount))
    }
}
