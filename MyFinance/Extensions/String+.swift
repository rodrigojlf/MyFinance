//
//  String+.swift
//  MyFinance
//
//  Created by Rodrigo Lima on 04/04/26.
//

import Foundation

extension String {
    
    // 1. Formatadores estáticos para garantir performance (Singleton-like)
    private static let parsingFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        // Opcional: Fixar o locale para evitar bugs com calendários não-gregorianos
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    
    private static let monthNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM" // "MMMM" retorna o nome completo do mês
        // Descomente a linha abaixo se quiser forçar português independente do idioma do iPhone
         formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    
    var monthName: String? {
        guard let date = String.parsingFormatter.date(from: self) else {
            return nil // Retorna nil se a string não estiver no formato exato "MM/yyyy"
        }
        return String.monthNameFormatter.string(from: date).uppercased()
    }
    
    var yearNumber: String {
            var result = ""
            result.append(contentsOf: self.split(separator: "/").last ?? "")
            return result
    }
}
