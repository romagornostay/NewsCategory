//
//  NetworkError.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

enum NetworkError: Error {
    
    case timeout
    case parsingFailure
    case noInternetConnection
    case cantBuildUrl
    case networkError
    
}
