//
//  MovieService.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import Foundation

class MovieService {
    
    static let shared = MovieService()
    private let apiClient = ApiClient()
    
    private init() {}
    
    let movieUrl = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=undefined&api_key=55957fcf3ba81b137f8fc01ac5a31fb5"
    
    func fetchMovies(completion: @escaping (Result<[Movie], ApiClient.ApiError>) -> Void) {
        guard let url = URL(string: movieUrl) else {
            return completion(.failure(.invalidRequest))
        }
        
        let request = URLRequest(url: url)
        
        apiClient.make(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(MovieResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(.decodingError))
                }
            case  .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
