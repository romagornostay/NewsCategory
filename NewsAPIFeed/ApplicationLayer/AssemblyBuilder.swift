//
//  AssemblyBuilder.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createNewsFeed(with coordinator: NewsCoordinatorProtocol) -> UIViewController
    func createNewsDetail(article: Article?, coordinator: NewsCoordinatorProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createNewsFeed(with coordinator: NewsCoordinatorProtocol) -> UIViewController {
        let newsViewController = NewsFeedViewController()
        let dataDisplayManager = NewsFeedDataDisplayManager()
        let service = NetworkService()
        let viewModel = NewsFeedViewModel(dataDisplayManager: dataDisplayManager, service: service, coordinator: coordinator)
        let newsFeedView = NewsFeedView(viewModel: viewModel, dataDisplayManager: dataDisplayManager)
        
        newsViewController.newsFeedView = newsFeedView
        
        return newsViewController
    }
    
    func createNewsDetail(article: Article?, coordinator: NewsCoordinatorProtocol) -> UIViewController {
        return UIViewController()
    }
    
}
