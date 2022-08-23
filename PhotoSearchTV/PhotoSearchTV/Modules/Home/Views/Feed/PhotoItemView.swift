//
//  PhotoItemView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct PhotoItemView: View {

    let item: FeedItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            Text(item.title ?? "")
                .font(.subheadline)
                .foregroundStyle(.white)
            Text(item.subTitle)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
        .padding(.bottom, 30)
        .background(
            asyncImage
            .clipped()
            .border(.gray)
        )
    }

    private var asyncImage: some View  {
        AsyncImage(url: item.imageURL) { phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }

            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            case .failure:
                HStack {
                    Spacer()
                    Image(systemName: "photo")
                        .imageScale(.large)
                    Spacer()
                }

            @unknown default:
                fatalError()
            }
        }
    }
}
