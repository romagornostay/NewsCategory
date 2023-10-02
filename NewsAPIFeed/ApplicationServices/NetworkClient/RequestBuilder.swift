//
//  RequestBuilder.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

protocol RequestBuilderProtocol: AnyObject {
    func build(request: any NetworkRequestProtocol) -> Result<URLRequest, NetworkError>
}

final class RequestBuilder: RequestBuilderProtocol {
    /// RequestBuilder
    func build(request: any NetworkRequestProtocol) -> Result<URLRequest, NetworkError> {
        guard let url = request.url else { return .failure(.cantBuildUrl) }
        let urlRequest = URLRequest(url: url, timeoutInterval: request.timeoutInterval)
        
        return .success(urlRequest)
    }
    
}
