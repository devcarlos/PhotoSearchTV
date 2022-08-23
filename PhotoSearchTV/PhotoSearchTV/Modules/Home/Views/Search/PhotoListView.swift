//
//  PhotoListView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct PhotoListView: View {
    
    let searchResult: SearchResult
    let searchQuery: String
    
    var body: some View {
        ScrollView {
            Text("Search Results for \"\(searchQuery)\"")
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)

            LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                ForEach(searchResult.photos.photo) { photo in
                    PhotoSearchView(photo: photo)
                        .focusable()
                        .frame(width: 480, height: 380)
                }
            }
            .padding()
        }
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 480), spacing: 25)]
    }
    
    private var gridSpacing: CGFloat? {
        30
    }
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}
