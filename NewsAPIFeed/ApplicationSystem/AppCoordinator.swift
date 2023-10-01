//
//  AppCoordinator.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    func start()
}

final class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    let newsCoordinator: NewsCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
        navigationController?.navigationBar.prefersLargeTitles = true
        assemblyBuilder = AssemblyBuilder()
        newsCoordinator = NewsCoordinator(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
    }
    
    func start() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .collectionViewCellBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.red]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        newsCoordinator.start()
    }
    
}

