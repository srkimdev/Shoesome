//
//  NumberFormatterManager.swift
//  Shopping Application
//
//  Created by 김성률 on 7/13/24.
//

import Foundation

final class NumberFormatterManager {
    
    static let shared = NumberFormatterManager()
    
    private init() { }
    
    func Comma(_ number: Int) -> String {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        let result = format.string(for: number)
        guard let decimalNumber = result else { return ""}
        
        return decimalNumber
    }
}
