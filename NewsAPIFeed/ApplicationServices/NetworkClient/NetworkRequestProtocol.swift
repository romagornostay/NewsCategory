//
//  NetworkRequestProtocol.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 02.10.2023.
//
import Foundation

protocol NetworkRequestProtocol: AnyObject {
    associatedtype Response
    
    var url: URL? { get }
    var timeoutInterval: Double { get }
    var responseConverter: ResponseConverter<Response> { get }
}

extension NetworkRequestProtocol where Response: Decodable {
    
    var responseConverter: ResponseConverter<Response> { ResponseConverter(with: DecodingResponseConverter()) }
    
}
