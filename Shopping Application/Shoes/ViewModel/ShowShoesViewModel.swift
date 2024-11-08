//
//  ShoesShowViewModel.swift
//  Shopping Application
//
//  Created by 김성률 on 10/22/24.
//

import Foundation

final class ShowShoesViewModel {
    
    var inputTrigger = Observable<Void>(())
    var inputBrand = Observable<BrandCategory>(.adidas)
    
    var outputBrandList = Observable<[SearchResultDetail]>([])
    var outputNewList = Observable<[SearchResultDetail]>([])
    var outputComplete = Observable<Void>(())
    
    init() {
        inputTrigger
            .bind { [weak self] _ in
                guard let self else { return }
                callAPI()
            }
        
        inputBrand
            .bind { [weak self] value in
                guard let self else { return }
                callBrand(brand: value)
            }
    }
    
    private func callAPI() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.callRequest(text: "나이키 덩크로우", start: 1, sort: Sorts.sim) { value, error  in
                guard let value else { return }
                
                let temp = value.items.filter { $0.mallName == "네이버" }
                self.outputBrandList.value = temp
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async {
            NetworkManager.shared.callRequest(text: "신발", start: 1, sort: Sorts.sim) { value, error in
                guard let value else { return }
                
                let temp = value.items.filter { $0.mallName == "네이버" }
                self.outputNewList.value = temp
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.outputComplete.value = ()
        }
    }
    
    private func callBrand(brand: BrandCategory) {
        NetworkManager.shared.callRequest(text: brand.rawValue, start: 1, sort: Sorts.date) { value, error in
            guard let value else { return }
            
            let temp = value.items.filter { $0.mallName == "네이버" }
            self.outputNewList.value = temp
        }
    }
    
}
