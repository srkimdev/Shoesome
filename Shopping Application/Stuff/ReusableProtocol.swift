//
//  ReusableProtocol.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit

// protocol for tableViewCell, collectionViewCell indentifier

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
