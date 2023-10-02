//
//  NewsDetailCoordinator.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 11.09.2023.
//

import UIKit
import SafariServices

protocol NewsDetailCoordinatorProtocol: AnyObject {
    func didOpenSafariConroller(withUrl url: URL)
}

final class NewsDetailCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func start() {}
        
    func openDetailViewWith(_ index: Int, articles: [Article]) {
        guard let navigationController,
              let detailViewController = assemblyBuilder?
            .createNewsDetail(for: index, articles: articles, coordinator: self) else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}

extension NewsDetailCoordinator: NewsDetailCoordinatorProtocol {
    
    func didOpenSafariConroller(withUrl url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .formSheet
        navigationController?.viewControllers.first?.present(safariViewController, animated: true)
    }
    
}
