//
//  UserInformation.swift
//  Shopping Application
//
//  Created by 김성률 on 7/11/24.
//

import UIKit

final class UserInfo {
    
    static let shared = UserInfo()
    
    let userDefault = UserDefaults.standard
    
    private init() { }
    
    var userName: String {
        get {
            return userDefault.string(forKey: "userName") ?? "DefaultUser"
        }
        set {
            userDefault.set(newValue, forKey: "userName")
        }
    }
    
    var profileNumber: Int {
        get {
            return userDefault.integer(forKey: "profileNumber")
        }
        set {
            userDefault.set(newValue, forKey: "profileNumber")
        }
    }
    
    var joinDate: String {
        get {
            return userDefault.string(forKey: "joinDate") ?? ""
        }
        set {
            userDefault.set(newValue, forKey: "joinDate")
        }
    }
    
    var recentSearchText: String {
        get {
            return userDefault.string(forKey: "recentSearchText") ?? ""
        }
        set {
            userDefault.set(newValue, forKey: "recentSearchText")
        }
    }
    
    func getLikeProduct(forkey: String) -> Bool {
        return userDefault.bool(forKey: forkey)
    }
    
    func setLikeProduct(isLike: Bool, forkey: String) {
        userDefault.set(isLike, forKey: forkey)
    }
}

