//
//  UserDefaultsManager.swift
//  Shopping Application
//
//  Created by 김성률 on 6/23/24.
//

import Foundation

class UserDefaultsManager {
    
    static var goToSearch: Bool {
        get { return UserDefaults.standard.bool(forKey: "goToSearch") }
        set { UserDefaults.standard.set(newValue, forKey: "goToSearch") }
    }

    static var mode: String {
        get { return UserDefaults.standard.string(forKey: "mode")! }
        set { UserDefaults.standard.set(newValue, forKey: "mode") }
    }
    
    static var searchList: [String] {
        get { return UserDefaults.standard.stringArray(forKey: "searchList") ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "searchList") }
    }
}
