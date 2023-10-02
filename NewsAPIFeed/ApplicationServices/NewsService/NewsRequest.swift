//
//  NewsRequest.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

final class NewsRequest: NetworkRequestProtocol {
    typealias Response = NewsResponse
    
    let url: URL?
    let timeoutInterval: Double
    
    init(for category: Category) {
        url = Constants.URLRequest.topHeadlines(about: category)
        timeoutInterval = Constants.URLRequest.timeoutInterval
    }
    
}

// MARK: - Constants
fileprivate extension NewsRequest {
    
    enum Constants {
        
        enum URLRequest {
            
            static let timeoutInterval: Double = 15
            static let key = "91af5ba9c3794b9ba9c9a5c6c9274166"
            
            static func everything() -> URL? {
              return URLRouter.everything(key: key).completed()
            }
            
            static func topHeadlines(about category: Category) -> URL? {
              return URLRouter.topHeadlines(key: key, category: category).completed()
            }
            
        }
        
    }
    
}


