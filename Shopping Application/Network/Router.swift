//
//  RouterPattern.swift
//  Shopping Application
//
//  Created by 김성률 on 7/21/24.
//

import Foundation
import Alamofire

enum RouterPattern {
    
    case shopping(text: String, start: Int, sort: Sorts)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/shop.json"
    }
    
    var endpoint: String {
        return baseURL
    }
    
    var header: HTTPHeaders {
        return [
            "X-Naver-Client-Id": APIkey.Id,
            "X-Naver-Client-Secret": APIkey.Secret
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .shopping(let text, let start, let sort):
            let parameters: Parameters = [
                "query": text,
                "display": 30,
                "start": start,
                "sort": sort.rawValue
            ]
            return parameters
        }
    }

}
