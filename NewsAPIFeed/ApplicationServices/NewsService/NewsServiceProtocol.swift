//
//  NewsServiceProtocol.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

protocol NewsServiceProtocol: AnyObject {
    func articles(for category: Category) async -> Result<NewsResponse, NetworkError>
}

