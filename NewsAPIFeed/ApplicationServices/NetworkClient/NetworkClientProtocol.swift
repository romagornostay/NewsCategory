//
//  NetworkClientProtocol.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

protocol NetworkClientProtocol: AnyObject {
    func send<Request: NetworkRequestProtocol>(request: Request) async -> Result<Request.Response, NetworkError>
}
