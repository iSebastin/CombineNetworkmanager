//
//  APIManager.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Combine
import Foundation


protocol APIManagerProtocol {
    func requestData<Request: APIRequest, T: Decodable>(
        request: Request, type: T.Type) -> AnyPublisher<T, NetworkError>
}


class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    init() {
        urlSession = URLSession.shared
    }
    
    func requestData<Request: APIRequest, T: Decodable>(
        request: Request, type: T.Type) -> AnyPublisher<T, NetworkError> {
            
            guard let url = URL(string: request.endPoint.path) else {
                return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.invalidURL))
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.allHTTPHeaderFields = request.headers
            urlRequest.httpBody = request.body
            
            return urlSession.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw NetworkError.invalidResponse
                    }
                    
                    guard 200..<300 ~= httpResponse.statusCode else {
                        throw NetworkError.invalidStatusCode(httpResponse.statusCode)
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    NetworkError.requestFailed(error)
                }
                .eraseToAnyPublisher()
        }
}
