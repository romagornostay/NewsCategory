//
//  NewsFeedViewState.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 17.09.2023.
//

import Foundation

enum NewsFeedViewState {
    
    case skeleton([NewsViewModel])
    case result([NewsViewModel])
    case empty//(EmptyStateViewModel)
    
}


// MARK: - Equatable
extension NewsFeedViewState: Equatable {
    
    static func == (lhs: NewsFeedViewState, rhs: NewsFeedViewState) -> Bool {
        switch (lhs, rhs) {
        case (let .result(lhsViewModels), let .result(rhsViewModels)):
            return lhsViewModels == rhsViewModels
        default:
            return false
        }
    }
    
}


