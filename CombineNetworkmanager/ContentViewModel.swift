//
//  ViewMode.swift
//  NetworkManager
//
//  Created by Victor Sebastin on 2023-09-17.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    
    enum State {
        case none
        case loading
        case loaded
    }
    
    @Published var articles = [Artwork]()
    @Published var state: State = .none
    var cancellables = Set<AnyCancellable>()
    
    func fetchAPI() {
        state = .loaded
        let requestData = APIRequestConfig(endPoint: .getArtWorks("cat"), method: .get)
        
        // Make a GET request
        let networkManager = APIManager()
        networkManager.requestData(request: requestData, type: ArtworkResponseModel.self)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print("error", error.localizedDescription)
                    self?.state = .none
                }
            } receiveValue: { [weak self] response in
                self?.articles = response
                self?.state = .loaded
            }
            .store(in: &cancellables)
    }
    
}
