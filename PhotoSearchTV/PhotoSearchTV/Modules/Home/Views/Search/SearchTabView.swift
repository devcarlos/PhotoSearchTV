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
        PhotoListView(searchResult: searchResult, searchQuery: searchQuery)
            .overlay(overlayView)
            .searchable(text: $searchVM.searchQuery, placement: .automatic) { suggestionsView }
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
            return SearchResult(stat: "", photos: PhotosPage(page: 0, pages: 0, perpage: 0, total: 0, photo: []))
        }
    }

    private var searchQuery: String {
        if case .success = searchVM.phase {
            return searchVM.searchQuery
        } else {
            return ""
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceholderView(text: "Type your query to search from Flickr API", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let searchResult) where searchResult.photos.photo.isEmpty:
            EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
            
        }
    }
    
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["News", "Haystack", "Breaking News", "Flickr"], id: \.self) { text in
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
