//
//  Numeric+Ext.swift
//  AccountsDemo
//
//  Created by SD on 06/12/23.
//

import Foundation

extension Double {
    
    func toCurrencyString(
        _ symbol: String = Helper.currencySign
    ) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = symbol
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.maximumFractionDigits = 2
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
