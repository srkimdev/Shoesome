//
//  MainSearchViewModel.swift
//  Shopping Application
//
//  Created by 김성률 on 7/10/24.
//

import Foundation

final class MainSearchViewModel {
    
    var searchList: [String] = UserDefaultsManager.searchList
    
    //MARK: Input
    var inputText: Observable<String> = Observable("")
    var deleteButtonTapped: Observable<Int> = Observable(-1)
    var deleteAllButtonTapped: Observable<Void> = Observable(())
    
    //MARK: Output
    var reloadDataTrigger: Observable<Void> = Observable(())
    
    init() {
        inputText
            .bind { [weak self] value in
                guard let self else { return }
                topToRecentSearch(search: value)
                reloadDataTrigger.value = ()
            }
        
        deleteButtonTapped
            .bind { [weak self] value in
                guard let self else { return }
                searchList.remove(at: value)
                reloadDataTrigger.value = ()
            }
        
        deleteAllButtonTapped
            .bind { [weak self] _ in
                guard let self else { return }
                searchList.removeAll()
                reloadDataTrigger.value = ()
            }
        
    }

    private func topToRecentSearch(search: String) {
        if searchList.contains(search) {
            searchList.removeAll { $0 == search }
        }
        searchList.insert(search, at: 0)
        UserDefaultsManager.searchList = searchList
    }
    
}
