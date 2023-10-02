//
//  NetworkClient.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {
    
    private let urlSession: URLSession = URLSession(configuration: .default)
    private let requestBuilder: RequestBuilderProtocol
    
    init(requestBuilder: RequestBuilderProtocol = RequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    /// NetworkClient
    func send<Request: NetworkRequestProtocol>(request: Request) async -> Result<Request.Response, NetworkError> {
        
        switch requestBuilder.build(request: request) {
        case .success(let urlRequest):
            return await send(urlRequest: urlRequest, responseConverter: request.responseConverter)
        case .failure(let error):
            return .failure(error)
            
        }
    }
    
    private func send<Converter: NetworkResponseConverterProtocol>(
        urlRequest: URLRequest,
        responseConverter: Converter) async -> Result<Converter.Response, NetworkError> {
            
            do {
                let (data, _) = try await urlSession.data(for: urlRequest)
                return decodeResponse(from: data, responseConverter: responseConverter)
            } catch {
                switch (error as? URLError)?.code {
                case .some(.notConnectedToInternet):
                    return .failure(.noInternetConnection)
                case .some(.timedOut):
                    return .failure(.timeout)
                default:
                    return .failure(.networkError)
                }
            }
        }
    
    private func decodeResponse<Converter: NetworkResponseConverterProtocol>(
        from data: Data,
        responseConverter: Converter) -> Result<Converter.Response, NetworkError> {
            if let response = responseConverter.decodeResponse(from: data) {
                return .success(response)
            }
            return .failure(.parsingFailure)
        }
    
}
