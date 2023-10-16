//
//  ArtWorkResponse.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Foundation

struct Thumbnail: Codable {
    let alt_text: String
    let width: Int
    let lqip: String
    let height: Int
}

struct Pagination: Codable {
    let total: Int
    let limit: Int
    let offset: Int
    let total_pages: Int
    let current_page: Int
}

struct Artwork: Codable {
    let _score: Double
    let thumbnail: Thumbnail
    let api_model: String
    let is_boosted: Bool
    let api_link: String
    let id: Int
    let title: String
    let timestamp: String
    var formattedTimeStamp: String {
        formatTimeStamp()
    }
    
    
    private func formatTimeStamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: timestamp) else {
            return ""
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate

    }
}

struct ArtworkResponseModel: Codable {
    let preference: String?
    let pagination: Pagination
    let data: [Artwork]
}




extension Artwork {
    static func mock() -> Artwork {
        Artwork(_score: 137.01839, thumbnail: Thumbnail.mock() , api_model: "artworks", is_boosted: false, api_link: "https://api.artic.edu/api/v1/artworks/656", id: 656, title: "Lion (One of a Pair, South Pedestal)", timestamp: "2023-09-16T23:32:39-05:00")
    }
}


extension Thumbnail {
    static func mock() -> Thumbnail {
        Thumbnail(alt_text: "A bronze lion, deep green and muscular, looks out in the distance from its pedestal in front of the Art Institute of Chicago.", width: 8430, lqip: "", height: 5620)
    }
}
