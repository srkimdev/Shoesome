//
//  HTMLManager.swift
//  Shopping Application
//
//  Created by 김성률 on 7/14/24.
//

import Foundation

final class HTMLManager {
    
    static let shared = HTMLManager()
    
    private init() { }
    
    func changeHTML(text: String) -> String {
        
        let result = text.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        return result
    }
}
