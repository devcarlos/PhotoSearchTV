//
//  PhotoListView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct PhotoListView: View {
    
    let searchResult: SearchResult
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                ForEach(searchResult.photos.photo) { photo in
                    PhotoSearchView(photo: photo)
                        .focusable()
                        .frame(width: 450, height: 400)
                }
            }
            .padding()
        }
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 450), spacing: 35)]
    }
    
    private var gridSpacing: CGFloat? {
        40
    }
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}
