//
//  HTTPStatus.swift
//  Shopping Application
//
//  Created by 김성률 on 7/14/24.
//

import UIKit
import Alamofire

enum APIError: String, Error {
    
    case incorrectQueryRequest = "SE01"
    case invalidDisplayValue = "SE02"
    case invalidStartValue = "SE03"
    case invalidSortValue = "SE04"
    case malformedEncoding = "SE06"
    case invalidSearchAPI = "SE05"
    case systemError = "SE99"
    case unknown
    
    var description: String {
        switch self {
        case .incorrectQueryRequest:
            return "Incorrect query request."
        case .invalidDisplayValue:
            return "Invalid display value."
        case .invalidStartValue:
            return "Invalid start value."
        case .invalidSortValue:
            return "Invalid sort value."
        case .malformedEncoding:
            return "Malformed encoding."
        case .invalidSearchAPI:
            return "Invalid search API"	
        case .systemError:
            return "System error"
        default:
            return "unknown error"
        }
    }
    
    static func from(errorCode: String) -> APIError {
        return APIError(rawValue: errorCode) ?? .unknown
    }
}
