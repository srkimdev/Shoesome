//
//  NetworkConnect.swift
//  Shopping Application
//
//  Created by 김성률 on 7/14/24.
//

import UIKit
import Reachability
import Toast

final class NetworkConnectManager {
    
    static let shared = NetworkConnectManager()
    private let reachability = try! Reachability()
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.connection == .wifi {
                    print("WiFi")
                } else {
                    print("Cellular")
                }
            }
        }
        
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                self.showToast(message: "not connected")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // check current network status
    func isNetworkAvailable() -> Bool {
        return reachability.connection != .unavailable
    }
    
    func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.makeToast(message, duration: 3.0, position: .bottom)
    }
}

