//
//  RealmRepository.swift
//  Shopping Application
//
//  Created by 김성률 on 7/8/24.
//

import UIKit
import RealmSwift

final class RealmRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ data: DBTable) {

        do {
            try! realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
        
    }
    
    func readAllItem() -> Results<DBTable> {
        return realm.objects(DBTable.self)
    }
    
    func deleteItem(_ data: DBTable) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
}

