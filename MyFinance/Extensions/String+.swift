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
    
    func currencyFormatting() -> String {
        // 1. Remove tudo que não for número
        let digits = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // 2. Converte para Double dividindo por 100 (para gerar os centavos)
        // Ex: "123" vira 1.23
        guard let doubleValue = Double(digits) else { return "" }
        let number = NSNumber(value: doubleValue / 100.0)
        
        // 3. Usa o NumberFormatter nativo para formatar como moeda
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: number) ?? ""
    }
    
    func dateFormatting() -> String {
        // 1. Remove tudo que não for número
        let digits = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // 2. Limita o tamanho máximo para 8 números (DDMMAAAA)
        let maxLength = 8
        let truncated = String(digits.prefix(maxLength))
        
        // 3. Insere as barras nos lugares corretos
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
