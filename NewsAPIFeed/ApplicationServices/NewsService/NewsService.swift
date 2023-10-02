//
//  NewsService.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

final class NewsService: NewsServiceProtocol {
 
    private let networkClient: NetworkClientProtocol
    
    init(with networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func articles(for category: Category) async -> Result<NewsResponse, NetworkError> {
        await networkClient.send(request: NewsRequest(for: category))
    }
    
}
