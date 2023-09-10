//
//  Article.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
    
}

// MARK: - Source
struct Source: Codable {
    
    let id: String?
    let name: String?
    
}

// MARK: - Article
struct Article: Codable {
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}
