//
//  Article.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import Foundation

// MARK: - Source
struct Source: Decodable {
    
    let id: String?
    let name: String?
    
}

// MARK: - Article
struct Article: Decodable {
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
    
}

extension Article {
    
    var publishedDate: String? {
        guard let date = publishedAt?.convertIntoDate() else { return "" }
        return date.format("dd MMM. yyyy")
    }
    
}
