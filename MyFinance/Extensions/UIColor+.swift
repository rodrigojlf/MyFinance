//
//  UIColor+.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    static let appMagenta = UIColor(hex: "#DA4BDD")
    static let appRed = UIColor(hex: "#D93A4A")
    static let appGreen = UIColor(hex: "#1FA342")
    
    static let gray100 = UIColor(hex: "#F9FBF9")
    static let gray200 = UIColor(hex: "#EFF0EF")
    static let gray300 = UIColor(hex: "#E5E6E5")
    static let gray400 = UIColor(hex: "#A1A2A1")
    static let gray500 = UIColor(hex: "#676767")
    static let gray600 = UIColor(hex: "#494A49")
    static let gray700 = UIColor(hex: "#0F0F0F")
}
