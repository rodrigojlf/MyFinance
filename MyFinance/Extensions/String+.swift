//
//  String+.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 04/04/26.
//

import Foundation

extension String {
    
    private static let parsingFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        formatter.calendar = Calendar.current
        formatter.locale = Locale.current
        return formatter
    }()
    
    private static let monthNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    
    var monthName: String? {
        guard let date = String.parsingFormatter.date(from: self) else {
            return nil
        }
        return String.monthNameFormatter.string(from: date).uppercased()
    }
    
    var yearNumber: String {
        guard let date = String.parsingFormatter.date(from: self) else {
            return String(self.split(separator: "/").last ?? "")
        }
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    func currencyFormatting() -> String {
        let digits = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        guard let doubleValue = Double(digits) else { return "" }
        let number = NSNumber(value: doubleValue / 100.0)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: number) ?? ""
    }
    
    func dateFormatting() -> String {
        let digits = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let maxLength = 8
        let truncated = String(digits.prefix(maxLength))
        
        var result = ""
        for (index, character) in truncated.enumerated() {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(character)
        }
        return result
    }
}
