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
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 24) {
                asyncImage
                    .frame(height: proxy.size.height * 0.6)
                    .background(Color.gray.opacity(0.6))
                    .clipped()

                VStack(alignment: .leading) {
                    Text(item.title ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .lineLimit(3)

                    Spacer(minLength: 12)

                    HStack {
                        Text(item.author ?? "")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
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
                    .aspectRatio(contentMode: .fill)

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
