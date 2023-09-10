//
//  NewsCoordinatorProtocol.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 10.09.2023.
//

import Foundation

protocol NewsCoordinatorProtocol: AnyObject {
    
    func didOpenDetailNews()
    func didOpenSafariConroller(withUrl url: URL)
    
}
