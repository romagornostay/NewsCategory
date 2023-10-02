//
//  NewsFeedViewModel.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 09.09.2023.
//

import Foundation

protocol NewsFeedViewModelProtocol: AnyObject {
    var articles: [Article]? { get set }
    func loadNews()
}

final class NewsFeedViewModel: NewsFeedViewModelProtocol {
    
    @MainActor weak var dataDisplayManager: NewsFeedDataDisplayManager?
    let newsService: NewsServiceProtocol
    var coordinator: NewsCoordinatorProtocol?
    var articles: [Article]?
    
    init(dataDisplayManager: NewsFeedDataDisplayManager, service: NewsServiceProtocol, coordinator: NewsCoordinatorProtocol) {
        self.dataDisplayManager = dataDisplayManager
        self.newsService = service
        self.coordinator = coordinator
    }

    private func mapToCellViewModel(from articles: [Article]?) -> [NewsViewModel] {
        guard let articles else { return [] }
        return articles.compactMap { NewsViewModel($0) }
    }
    
    // MARK: - Load news
    func loadNews() {
        Task {
            await dataDisplayManager?.setupState(.skeleton(NewsViewModel.tenViewModels))
            await proceedToLoadNews()
        }
    }
    
    private func proceedToLoadNews() async {
        // TODO: - Loading news for diffrent categories with PageViewContriller like Airbnb
        let result = await newsService.articles(for: .business)
        
        switch result {
        case .success(let response):
            await handleNewsLoading(response)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func handleNewsLoading(_ response: NewsResponse) async {
        self.articles = response.articles
        await dataDisplayManager?.setupState(.result(response.articles.compactMap { NewsViewModel($0) }))
    }
      
    
}
// MARK: - NewsFeedView outputs
extension NewsFeedViewModel: NewsFeedViewOutput {
    
    func didTriggerLoadNews() {
        loadNews()
    }
    
    func didTriggerCellSelected(atIndex index: Int) {
        guard let articles else { return }
        coordinator?.didOpenDetailNews(for: index, articles: articles)
    }
    
    func didTriggerPullToRefresh() {
        loadNews()
    }
    
}
