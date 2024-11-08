//
//  Struct.swift
//  Shopping Application
//
//  Created by 김성률 on 6/14/24.
//

import UIKit

struct SearchResult: Decodable {
    let total: Int
    let display: Int
    let items: [SearchResultDetail]
}

struct SearchResultDetail: Decodable, Hashable {
    let title: String
    let link: String
    let image: String
    let mallName: String
    let productId: String
    let lprice: String
    let category1: String
    let category2: String
    let category3: String
}

// this is for reusing ProfileSettingViewController
enum ProfileMode: String {
    case setup
    case edit
}

enum CustomDesign {
    
    static let viewBackgoundColor: UIColor = .white
    static let itemTintColor: UIColor = .black
    static let profileBorderWidth3: CGFloat = 3
    static let profileBorderWidth1: CGFloat = 1
    static let lineColor: UIColor = .systemGray5
    
    static let orange: UIColor = UIColor(hex: "#D499F0")
//    #colorLiteral(red: 0.8805426955, green: 0.5620557666, blue: 0.3212787211, alpha: 1)
    static let likeImage: UIImage = UIImage(named: "like_selected")!
    static let unlikeImage: UIImage = UIImage(named: "like_unselected")!
    
}

struct ConstantTable {
    static var likeCount = 0
    static var sortOption = 0
    static let settingCell = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    static let arrayButton = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    static let profileImageNumber = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
}

enum Sorts: String, CaseIterable {
    case sim
    case date
    case dsc
    case asc
}
