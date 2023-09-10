//
//  NewsViewModel.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import UIKit

struct NewsViewModel: Hashable {
    
    let title: String
    let subtitle: String
    var imageURL: URL?
    var imageData: Data?

}
