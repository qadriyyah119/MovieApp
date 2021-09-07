//
//  Movie.swift
//  MovieApp
//
//  Created by Qadriyyah Thomas on 9/7/21.
//

import Foundation

class Movie: Decodable {
    var id: Int
    var title: String?
    var posterImage: String?
    var releaseDate: Date?
    var voteAverage: Double?
    var voteCount: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        posterImage = try container.decodeIfPresent(String.self, forKey: .posterImage)
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd'T'hh:mm:ss"
            releaseDate = formatter.date(from: releaseDateString)
        }
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterImage = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}

class MovieResponse: Decodable {
    var page: Int?
    var results: [Movie] = []
    var totalPages: Int?
    var totalResults: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        results = try container.decodeIfPresent([Movie].self, forKey: .results) ?? []
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
