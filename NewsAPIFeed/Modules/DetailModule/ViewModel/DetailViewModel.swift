//
//  DetailViewModel.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 11.09.2023.
//

import SwiftUI

final class DetailViewModel: ObservableObject {
    
    var newsIndex: Int {
        didSet {
            print(newsIndex)
        }
    }
    let articles: [Article]
    private let coordinator: NewsDetailCoordinatorProtocol
    @Published var closePresenter = false
    
    init(newsIndex: Int, articles: [Article], coordinator: NewsDetailCoordinatorProtocol) {
        self.newsIndex = newsIndex
        self.articles = articles
        self.coordinator = coordinator
//        if articles[newsIndex].url == nil { closePresenter = true }
        print("open news at index --> \(newsIndex)")
    }
    
    func openNewsUrl() {
        print("open URL news at index --> \(newsIndex)")
        if let url = articles[newsIndex].url {
            coordinator.didOpenSafariConroller(withUrl: url)
//            UIApplication.shared.open(url)
        }
    }
    
}

