//
//  PhotoListView.swift
//  PhotoSearchTV
//
//  Created by Mac Mini on 20/8/22.
//

import SwiftUI

struct PhotoListView: View {
    
    let photos: [Photo]
    
    var body: some View {
        rootView
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                ForEach(photos) { photo in
                    NavigationLink {
                        PhotoDetailView(photo: photo)
                    } label: {
                        PhotoItemView(photo: photo)
                            .frame(width: 400, height: 400)
                    }
                    .buttonStyle(.card)
                }
            }
            .padding()
        }
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 400), spacing: 32)]
    }
    
    private var gridSpacing: CGFloat? {
        48
    }
    
    @ViewBuilder
    private var rootView: some View {
        gridView
    }
    
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}
