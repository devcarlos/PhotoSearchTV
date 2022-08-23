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
        NavigationView {
            VStack {
                Text("Cats Feed on Flickr")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)

                ScrollView(.vertical) {
                    LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                        ForEach(feed?.items ?? [], id: \.dateTaken) { item in
                            NavigationLink(destination: PhotoDetail(item: item), label: {
                                PhotoItemView(item: item)
                                    .focusable()
                                    .frame(width: 570, height: 380)
                            })
                        }
                    }
                    .padding()
                }
            }
            .background(Color.black)
        }
    }
    
    private var gridItems: [GridItem] {
        [GridItem(.adaptive(minimum: 570), spacing: 25)]
    }
    
    private var gridSpacing: CGFloat? {
        50
    }
}
