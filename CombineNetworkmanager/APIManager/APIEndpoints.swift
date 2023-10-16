//
//  APIEndpoint.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Foundation

protocol URLEndpoint {
    var path: String { get }
}

enum APIEndpoint: URLEndpoint {
    case getArtWorks(String)
    
    var path: String {
        switch self {
        case .getArtWorks(let searchText):
            return "https://api.artic.edu/api/v1/artworks/search?q=\(searchText)"
        }
    }
}
