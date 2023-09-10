//
//  URLRouter.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import Foundation

enum URLRouter {
    
    case everything(key: String)
    case topHeadlines(key: String, category: Category)
    
    var scheme: String {
        
        switch self {
        case .everything, .topHeadlines: return "https"
        }
        
    }
    
    var host: String {
        
        switch self {
        case .everything, .topHeadlines: return "newsapi.org"
        }
        
    }
    
    var path: String {
        
        switch self {
        case .everything:   return "/v2/everything"
        case .topHeadlines: return "/v2/top-headlines"
        }
        
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
        case .everything(let key): return [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "apiKey", value: key)]
        case .topHeadlines(let key, let category): return [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "category", value: category.rawValue),
            URLQueryItem(name: "apiKey", value: key)]
        }
        
    }
    
    func completed() -> URL? {
        
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
        
    }
}
