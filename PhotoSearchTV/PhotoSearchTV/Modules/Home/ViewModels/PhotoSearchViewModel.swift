//
//  PhotoSearchViewModel.swift
//  PhotoSearchTV
//
//  Created by Mac Mini on 20/8/22.
//

import Combine
import SwiftUI

@MainActor
class PhotoSearchViewModel: ObservableObject {

    @Published var phase: DataFetchPhase<[Photo]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    @Published var currentSearch: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var service: ServiceProtocol?
    
    static let shared = PhotoSearchViewModel()
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private init(service: ServiceProtocol? = PhotoService()) {
        self.service = service
        observeSearchQuery()
    }
    
    private func observeSearchQuery() {
        $searchQuery
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in
                    guard let self = self else { return }
                    await self.searchPhoto()
                }
            }
            .store(in: &cancellables)
    }

    func searchPhoto() async {
        if Task.isCancelled { return }
        
        let searchQuery = trimmedSearchQuery
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        currentSearch = searchQuery
        do {
            let photos = try await service?.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .success(photos)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .failure(error)
        }
    }
}
