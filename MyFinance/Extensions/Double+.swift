//
//  Double+.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 05/04/26.
//

import Foundation

extension Double {
    
    private static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var decimalFormatted: String {
        return Double.decimalFormatter.string(from: NSNumber(value: self)) ?? "0,00"
    }
}
