//
//  PhotoSearchView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import SwiftUI

struct PhotoSearchView: View {

    let photo: Photo

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Text(photo.title ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 60)
            .background(asyncImage
                .frame(height: proxy.size.height * 0.75)
                .clipped()
            )
        }
    }

    private var asyncImage: some View {
        AsyncImage(url: photo.imageURL) { phase in
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