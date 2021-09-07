//
//  ImageConfigurationCache.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import Foundation

class ImageConfigurationCache {
    
    static let shared = ImageConfigurationCache()
    private(set) var configurationCache: ImageConfiguration?
    private let apiClient = ApiClient()
    
    private let configurationBaseUrl = "https://api.themoviedb.org/3/configuration?api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
    
    private init() {}
    
    func configure() {
        guard configurationCache == nil else { return }
        
        self.getConfiguration { result in
            switch result {
            case .success(let imageConfiguration):
                self.configurationCache = imageConfiguration
            case .failure:
                break
            }
        }
    }
    
    private func getConfiguration(completion: @escaping (Result<ImageConfiguration, ApiClient.ApiError>) -> Void) {
        guard let url = URL(string: configurationBaseUrl) else {
            return completion(.failure(.invalidRequest))
        }
        
        let request = URLRequest(url: url)
        
        apiClient.make(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(ImageConfiguration.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
