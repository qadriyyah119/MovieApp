//
//  ImageConfiguration.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import Foundation

class ImageConfiguration: Decodable {
    var secureBaseUrl: String?
    var backdropSizes: [String?] = []
    var logoSizes: [String?] = []
    var posterSizes: [String?] = []
    var profileSizes: [String?] = []
    var stillSizes: [String?] = []
    
    required init(from decoder: Decoder) throws {
        let Outercontainer = try decoder.container(keyedBy: OuterKeys.self)
        let container = try Outercontainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .images)
        
        secureBaseUrl = try container.decodeIfPresent(String.self, forKey: .secureBaseUrl)
        backdropSizes = try container.decodeIfPresent([String?].self, forKey: .backdropSizes) ?? []
        logoSizes = try container.decodeIfPresent([String?].self, forKey: .logoSizes) ?? []
        posterSizes = try container.decodeIfPresent([String?].self, forKey: .posterSizes) ?? []
        profileSizes = try container.decodeIfPresent([String?].self, forKey: .profileSizes) ?? []
        stillSizes = try container.decodeIfPresent([String?].self, forKey: .stillSizes) ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    enum OuterKeys: String, CodingKey {
        case images = "images"
    }
}
