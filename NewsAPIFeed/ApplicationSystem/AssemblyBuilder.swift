//
//  AssemblyBuilder.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit
import SwiftUI

protocol AssemblyBuilderProtocol {
    func createNewsFeed(with coordinator: NewsCoordinatorProtocol) -> UIViewController
    func createNewsDetail(for index: Int, articles: [Article], coordinator: NewsDetailCoordinatorProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createNewsFeed(with coordinator: NewsCoordinatorProtocol) -> UIViewController {
        let newsViewController = NewsFeedViewController()
        let dataDisplayManager = NewsFeedDataDisplayManager()
        let service = NetworkService()
        
        let viewModel = NewsFeedViewModel(dataDisplayManager: dataDisplayManager, service: service, coordinator: coordinator)
        let newsFeedView = NewsFeedView(viewModel: viewModel, dataDisplayManager: dataDisplayManager)
        
        newsFeedView.output = viewModel
        newsViewController.newsFeedView = newsFeedView
        
        return newsViewController
    }
    
    func createNewsDetail(for index: Int, articles: [Article], coordinator: NewsDetailCoordinatorProtocol) -> UIViewController {
        let viewModel = DetailViewModel(newsIndex: index, articles: articles, coordinator: coordinator)
        let view = DetailView(viewModel: viewModel)
        let detailViewController = NewsDetailViewController(rootView: view)
        
        return detailViewController
    }
    
}
