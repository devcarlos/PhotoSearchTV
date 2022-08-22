//
//  PhotoSearchViewModel.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Combine
import SwiftUI

@MainActor
class PhotoSearchViewModel: ObservableObject {

    @Published var phase: DataFetchPhase<SearchResult> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    @Published var currentSearch: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var service: PhotoServiceProtocol?
    
    static let shared = PhotoSearchViewModel()
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private init(service: PhotoServiceProtocol? = PhotoService()) {
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
        
        let query = trimmedSearchQuery
        phase = .empty
        
        if query.isEmpty {
            return
        }
        
        currentSearch = query
        do {
            guard let searchResult = try await service?.search(with: query) else {
                return
            }
            if Task.isCancelled { return }
            if query != trimmedSearchQuery {
                return
            }
            phase = .success(searchResult)
        } catch {
            if Task.isCancelled { return }
            if query != trimmedSearchQuery {
                return
            }
            phase = .failure(error)
        }
    }
}
