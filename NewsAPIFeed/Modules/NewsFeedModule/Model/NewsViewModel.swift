//
//  NewsViewModel.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

struct NewsViewModel: Hashable {
    
    let id = UUID().uuidString
    var title: String
    var subtitle: String
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
    
    static var defaultModel: NewsViewModel {
        var model = NewsViewModel()
        model.title = "The Mortgage Market Is So Bad Lenders Want Ex-Employees to Give Back Their Bonuses"
        model.subtitle = "The mortgage industry is notoriously feast or famine, but there’s no obvious way out of this bust"
        model.imageURL = URL(string: "https://images.wsj.net/im-877315/social")
        return model
    }
        
}
