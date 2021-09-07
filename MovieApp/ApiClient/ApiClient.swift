//
//  ApiClient.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import Foundation

class ApiClient {
    
    enum ApiError: Error {
        case networkError
        case decodingError
        case invalidData
        case invalidRequest
        case imageError
    }
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    func make(request: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void) {
        defer {
            self.dataTask = nil
        }
        
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completion(.failure(.networkError))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
                completion(.success(data))
            
        }
        dataTask?.resume()
    }
}
