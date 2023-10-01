//
//  File.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 09.09.2023.
//

import Foundation

protocol NewsFeedViewModelProtocol {
    func getArticles()
    var articles: [Article]? { get set }
}

final class NewsFeedViewModel: NewsFeedViewModelProtocol {

    weak var dataDisplayManager: NewsFeedDataDisplayManager?
    let networkService: NetworkServiceProtocol
    var coordinator: NewsCoordinatorProtocol?
    var articles: [Article]?
    
    init(dataDisplayManager: NewsFeedDataDisplayManager, service: NetworkServiceProtocol, coordinator: NewsCoordinatorProtocol) {
        self.dataDisplayManager = dataDisplayManager
        self.networkService = service
        self.coordinator = coordinator
    }
    
    func getArticles() {
        dataDisplayManager?.setupState(.skeleton(NewsViewModel.tenViewModels))
        networkService.getArticles(for: .health) { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                let models = self.mapToCellViewModel(from: articles)
                self.dataDisplayManager?.setupState(.result(models))
            case .failure(_):
                print("Sone Errors!!!")
            }
        }
    }
    
    private func mapToCellViewModel(from articles: [Article]?) -> [NewsViewModel] {
        guard let articles else { return [] }
        return articles.compactMap { NewsViewModel($0) }
    }
    
}
// MARK: - NewsFeedView outputs
extension NewsFeedViewModel: NewsFeedViewOutput {
    
    func didTriggerLoadNews() {
        getArticles()
    }
    
    func didTriggerCellSelected(atIndex index: Int) {
        guard let articles else { return }
        coordinator?.didOpenDetailNews(for: index, articles: articles)
    }
    
    func didTriggerPullToRefresh() {
        getArticles()
    }
    
}
