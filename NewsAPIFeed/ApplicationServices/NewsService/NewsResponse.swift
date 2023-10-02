//
//  NewsResponse.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

struct NewsResponse: Decodable {
   
    let status: String
    let totalResults: Int
    let articles: [Article]
    
}

