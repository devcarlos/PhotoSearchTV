//
//  PhotoListView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 22/8/22.
//

import SwiftUI

struct PhotoFeedView: View {
    
    let feed: FlickrFeed?
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                ForEach(feed?.items ?? [], id: \.dateTaken) { item in
                    PhotoItemView(item: item)
                        .focusable()
                        .frame(width: 550, height: 450)
                }
            }
            .padding()
        }
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 550), spacing: 35)]
    }
    
    private var gridSpacing: CGFloat? {
        48
    }
}
