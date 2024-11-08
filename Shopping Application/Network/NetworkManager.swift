//
//  APIManager.swift
//  Shopping Application
//
//  Created by 김성률 on 7/12/24.
//

import UIKit
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequest (
        text: String,
        start: Int,
        sort: Sorts,
        completionHandler: @escaping (SearchResult?, APIError?) -> Void)
    {
        
        var components = URLComponents(string: "https://openapi.naver.com/v1/search/shop.json")!
        components.queryItems = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "start", value: String(start)),
            URLQueryItem(name: "sort", value: sort.rawValue)
        ]
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIkey.Id, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIkey.Secret, forHTTPHeaderField: "X-Naver-Client-Secret")

        URLSession.shared.dataTask(with: request) { data, response, error in
           
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completionHandler(nil, APIError.systemError)
                    return
                }
                
                guard let data else {
                    completionHandler(nil, APIError.incorrectQueryRequest)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidSearchAPI)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completionHandler(nil, .malformedEncoding)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .unknown)
                }
                
            }
            
        }.resume()
        
    }
    
}
