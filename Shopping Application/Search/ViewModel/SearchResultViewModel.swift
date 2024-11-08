//
//  SearchResultViewModel.swift
//  Shopping Application
//
//  Created by 김성률 on 7/12/24.
//

import Foundation
import RealmSwift

final class SearchResultViewModel {
    
    var callAPI: Observable<Void> = Observable(())
    var inputButton: Observable<Int> = Observable(0)
    var inputPagination: Observable<Void> = Observable(())
    var inputLikeButton: Observable<SearchResultDetail?> = Observable(nil)
    
    var outputList: Observable<[SearchResultDetail]> = Observable([])
    var outputCount: Observable<Int> = Observable(0)
    var outputLike: Observable<Void> = Observable(())
    
    var outputScrollToTop: Observable<Void?> = Observable(nil)
    var outputPagination: Observable<Void?> = Observable(nil)
    
    private let realmrepository = RealmRepository()
    
    var searchText: String
    var sort: Sorts = .sim
    var start = 1
    var totalPage = 0
    
    init(searchText: String) {
        self.searchText = searchText
        
        callAPI
            .bind { [weak self] _ in
                guard let self else { return }
                fetchData()
            }
        
        inputButton
            .bind { [weak self] value in
                guard let self else { return }
                sort = Sorts.allCases[value]
                fetchData()
            }
        
        inputPagination
            .bind { [weak self] value in
                guard let self else { return }
                loadMoreData()
            }
        
        inputLikeButton
            .bind { [weak self] value in
                guard let self, let value else { return }
                let temp = DBTable(productId: value.productId, image: value.image, mallName: value.mallName, title: value.title, lprice: value.lprice, link: value.link, category3: value.category3)
                
                realmrepository.createItem(temp)
                
                UserDefaults.standard.set(true, forKey: value.productId)
                outputLike.value = ()
            }
        
        outputList
            .bind { [weak self] value in
                guard let self else { return }
                
                if start == 1 && value.count > 0 {
                    outputScrollToTop.value = ()
                } else if start > 1 && value.count > 0 {
                    outputPagination.value = ()
                }
            }
        
    }

    private func fetchData() {
        NetworkManager.shared.callRequest(text: searchText, start: start, sort: sort) { value, error in
            guard let value else { return }
            
            self.outputList.value = value.items
            self.outputCount.value = value.total
            self.totalPage = value.total
        }
    }
    
    private func loadMoreData() {
        start += 30
        guard totalPage != start else { return }
        
        NetworkManager.shared.callRequest(text: searchText, start: start, sort: sort) { value, error in
            guard let value else { return }
            
            self.outputList.value.append(contentsOf: value.items)
        }
    }
    
}
