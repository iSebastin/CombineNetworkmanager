//
//  APIRequestConfig.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Foundation


struct APIRequestConfig: APIRequest {
    var endPoint: APIEndpoint
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
    
    init(endPoint: APIEndpoint, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) {
        self.endPoint = endPoint
        self.method = method
        self.headers = headers
        self.body = body
    }
}


// HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APIRequest {
    var endPoint: APIEndpoint { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed(Error)
}

