//
//  NewsCoordinator.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit
import SafariServices

final class NewsCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    let newsDetailCoordinator: NewsDetailCoordinator
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
        newsDetailCoordinator = NewsDetailCoordinator(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }
    
    func start() {
        guard let navigationController,
              let newsFeedViewController = assemblyBuilder?.createNewsFeed(with: self) else { return }
        navigationController.viewControllers = [newsFeedViewController]
    }
}

extension NewsCoordinator: NewsCoordinatorProtocol {
    
    func didOpenDetailNews(for index: Int, articles: [Article]) {
        newsDetailCoordinator.openDetailViewWith(index, articles: articles)
    }
    
}

