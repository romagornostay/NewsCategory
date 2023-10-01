//
//  NewsFeedViewController.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var newsFeedView: NewsFeedView?
    
    override func loadView() {
        title = "News"
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeedView?.didTriggerViewReadyForLoadNews()
    }
    
}

