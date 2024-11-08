//
//  DBTable.swift
//  Shopping Application
//
//  Created by 김성률 on 7/7/24.
//

import Foundation
import RealmSwift

final class DBTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var productId: String
    @Persisted var image: String
    @Persisted var mallName: String
    @Persisted var title: String
    @Persisted var lprice: String
    @Persisted var link: String
    @Persisted var category3: String
    
    convenience init(productId: String, image: String, mallName: String, title: String, lprice: String, link: String, category3: String) {
        self.init()
        self.productId = productId
        self.image = image
        self.mallName = mallName
        self.title = title
        self.lprice = lprice
        self.link = link
        self.category3 = category3
    }
}
