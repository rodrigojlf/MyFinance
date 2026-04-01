//
//  UIFont+.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 01/04/26.
//

import UIKit

extension UIFont {
    private static func latoRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    private static func latoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    private static func latoExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Black", size: size) ?? .systemFont(ofSize: size, weight: .heavy)
    }
    
    static var titleLg: UIFont { latoExtraBold(size: 28) }
    static var titleMd: UIFont { latoBold(size: 16) }
    static var titleSm: UIFont { latoBold(size: 14) }
    static var titleXs: UIFont { latoBold(size: 12) }
    static var title2Xs: UIFont { latoBold(size: 10) }
    
    static var textSm: UIFont { latoRegular(size: 14) }
    static var textSmBold: UIFont { latoBold(size: 14) }
    static var textXs: UIFont { latoRegular(size: 12) }
    
    static var input: UIFont { latoRegular(size: 16) }
    static var buttonMd: UIFont { latoBold(size: 16) }
    static var buttonSm: UIFont { latoBold(size: 14) }
}
