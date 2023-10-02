//
//  NewsFeedViewController.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var newsFeedView: NewsFeedView?
    /// disposeBag for ViewModel
    private var disposeBag: Any?
    
    override func loadView() {
        title = "News"
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeedView?.didTriggerViewReadyForLoadNews()
    }
    
    // MARK: - disposeBag
    func addDisposeBag(_ disposeBag: Any) {
        self.disposeBag = disposeBag
    }
    
}

