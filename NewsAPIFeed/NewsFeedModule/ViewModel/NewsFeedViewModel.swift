//
//  File.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 09.09.2023.
//

import Foundation

protocol NewsFeedViewModelProtocol {
    func getArticles()
}

final class NewsFeedViewModel: NewsFeedViewModelProtocol {
    
    weak var dataDisplayManager: NewsFeedDataDisplayManager?
    let networkService: NetworkServiceProtocol
    var coordinator: NewsCoordinatorProtocol?
    
    init(dataDisplayManager: NewsFeedDataDisplayManager, service: NetworkServiceProtocol, coordinator: NewsCoordinatorProtocol) {
        self.dataDisplayManager = dataDisplayManager
        self.networkService = service
        self.coordinator = coordinator
        getArticles()
    }
    
    func getArticles() {
        networkService.getArticles(for: .health) { result in
            switch result {
            case .success(let articles):
                let models = self.mapToCellViewModel(from: articles)
                self.dataDisplayManager?.setup(with: models)
            case .failure(_):
                print("Sone Errors!!!")
            }
        }
    }
    
    private func mapToCellViewModel(from articles: [Article]?) -> [NewsViewModel] {
        guard let articles else { return [] }
        return articles.compactMap { article in
            NewsViewModel(
                title: article.title ?? "No Title",
                subtitle: article.description ?? "No Description",
                imageURL: URL(string: article.urlToImage ?? ""))
        }
    }
    
}
