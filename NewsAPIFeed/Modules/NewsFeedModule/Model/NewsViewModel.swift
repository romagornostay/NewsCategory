//
//  NewsViewModel.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

struct NewsViewModel: Hashable {
    
    let id = UUID().uuidString
    let title: String
    let subtitle: String
    var imageURL: URL?
    var imageData: Data?
    
    init(_ article: Article) {
        self.title = article.title ?? "No Title"
        self.subtitle = article.description ?? "No Description"
        self.imageURL = article.urlToImage
    }

}

extension NewsViewModel {
    private init() {
        self.title = "skeleton"
        self.subtitle = ""
    }
    
    static var tenViewModels: [NewsViewModel] {
        var array: [NewsViewModel] = []
        for _ in 1...10 {
            let model = NewsViewModel()
            array.append(model)
        }
        return array
    }
        
}
