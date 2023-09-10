//
//  NetworkService.swift
//  NewsAPIFeed
//
//  Created by Роман Горностаев on 08.09.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getArticles(for category: Category, complection: @escaping (Result<[Article]?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol{
    
    func getArticles(for category: Category, complection: @escaping(Result<[Article]?, Error>) -> Void) {
        guard let url = Constants.Url.topHeadlines(about: category) else { return }
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            DispatchQueue.main.async {
                if let error {
                    complection(.failure(error))
                }
                else if let data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        complection(.success(result.articles))
                    }
                    catch {
                        complection(.failure(error))
                    }
                }
            }
            
        }
        task.resume()
    }
    
}

// MARK: - Constants
extension NetworkService {
    
    enum Constants {
        
        enum Url {
            
            static let key = "91af5ba9c3794b9ba9c9a5c6c9274166"
            static func everything() -> URL? {
                URLRouter.everything(key: key).completed()
            }
            static func topHeadlines(about category: Category) -> URL? {
                URLRouter.topHeadlines(key: key, category: category).completed()
            }
            
        }
        
    }
    
}

