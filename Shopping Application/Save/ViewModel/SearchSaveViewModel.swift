//
//  SearchSaveViewModel.swift
//  Shopping Application
//
//  Created by 김성률 on 7/15/24.
//

import Foundation
import RealmSwift

class SearchSaveViewModel {
    
    var inputTrigger: Observable<Void> = Observable<Void>(())
    var outputResult: Observable<[SearchResultDetail]> = Observable<[SearchResultDetail]>([])
    var outputPrice: Observable<Int> = Observable<Int>(0)
    
    var tempForSearchResultDetail: [SearchResultDetail] = []
    var totalPrice: Int = 0
    
    private let realmrepository = RealmRepository()

    init() {
        inputTrigger
            .bind { [weak self] _ in
                guard let self else { return }
                tempForSearchResultDetail = []
                totalPrice = 0
                
                readData()
            }
        
        realmrepository.detectRealmURL()
    }
    
    private func readData() {
        let data = realmrepository.readAllItem()
        
        for item in data {
            let temp = SearchResultDetail(title: item.title, link: item.link, image: item.image, mallName: item.mallName, productId: item.productId, lprice: item.lprice, category1: "", category2: "", category3: item.category3)
            
            totalPrice += Int(item.lprice) ?? 0
            tempForSearchResultDetail.append(temp)
        }
        
        outputResult.value = tempForSearchResultDetail
        outputPrice.value = totalPrice
    }
    

}




