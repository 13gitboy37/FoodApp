//
//  NetworkService.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 16.10.2022.
//

import Foundation


final class NetworkService {
    lazy var mySession = URLSession(configuration: configuration)
    
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        return config
    }()
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "api.punkapi.com"
        return constructor
    }()
    
    func fetchMenu(completion: @escaping (Result<[Beer],Error>) -> Void) {
        
        urlConstructor.path = "/v2/beers"
        
        guard
            let url = urlConstructor.url
        else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let repoResponse = try JSONDecoder().decode([Beer].self, from: data)
                completion(.success(repoResponse))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
