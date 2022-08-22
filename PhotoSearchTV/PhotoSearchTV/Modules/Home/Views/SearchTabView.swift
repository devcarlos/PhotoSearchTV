//
//  SearchTabView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct SearchTabView: View {

    @StateObject var searchVM = PhotoSearchViewModel.shared
    
    var body: some View {
        PhotoListView(searchResult: searchResult)
            .overlay(overlayView)
            .searchable(text: $searchVM.searchQuery)
            .onChange(of: searchVM.searchQuery) { newValue in
                if newValue.isEmpty {
                    searchVM.phase = .empty
                }
            }
    }
    
    private var searchResult: SearchResult {
        if case .success(let searchResult) = searchVM.phase {
            return searchResult
        } else {
            return SearchResult(photos: PhotosPage(page: 0, pages: 0, perpage: 0, total: 0, photos: []))
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceholderView(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let searchResult) where searchResult.photos.photos.isEmpty:
            EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
            
        }
    }
    
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS 15"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
    private func search() {
        Task {
            await searchVM.searchPhoto()
        }
    }
}
