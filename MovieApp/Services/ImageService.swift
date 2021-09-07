//
//  ImageService.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import UIKit

class ImageService {
    
    enum ImageError: Error {
        case imageError
        case decodingError
    }
    
    enum ImageType {
        case backdrop(imageSize: String)
        case logo(imageSize: String)
        case poster(imageSize: String)
        case profile(imageSize: String)
        case still(imageSize: String)
    }
    
    static let shared = ImageService()
    private(set) var apiClient = ApiClient()
    
    
    
    private init() {}
    
    func fetchImage(forType imageType: ImageType, filePath: String, completion: @escaping(Result<UIImage?, ImageError>) -> Void) {
        
        guard let secureBaseUrl = ImageConfigurationCache.shared.configurationCache?.secureBaseUrl else {
            return completion(.failure(.imageError))
        }
        var imageSize: String  {
            switch imageType {
            case .profile(let imageSize):
                return imageSize
            default:
                return "original"
            }
        }
        
        guard let url = URL(string: "\(secureBaseUrl)/\(imageSize)/\(filePath)") else {
            return completion(.failure(.imageError))
        }
        let request = URLRequest(url: url)
        
        apiClient.make(request: request) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                completion(.success(image))
                
            case .failure:
                completion(.failure(.imageError))
            }
        }
    }
}

