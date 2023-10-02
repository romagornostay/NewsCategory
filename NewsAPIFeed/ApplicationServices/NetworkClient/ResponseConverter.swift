//
//  ResponseConverter.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//

import Foundation

protocol NetworkResponseConverterProtocol: AnyObject {
    associatedtype Response
    
    func decodeResponse(from data: Data) -> Response?
}

final class ResponseConverter<Response>: NetworkResponseConverterProtocol {
    
    private let decodeResponse: (Data) -> Response?
    
    init<Converter: NetworkResponseConverterProtocol>(with converter: Converter) where Converter.Response == Response {
        decodeResponse = { data in
            converter.decodeResponse(from: data)
        }
    }
    
    func decodeResponse(from data: Data) -> Response? {
        decodeResponse(data)
    }
    
}

final class DecodingResponseConverter<Response>: NetworkResponseConverterProtocol where Response: Decodable {
    
    func decodeResponse(from data: Data) -> Response? {
        try? JSONDecoder().decode(Response.self, from: data)
    }
    
}
