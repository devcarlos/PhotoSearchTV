//
//  FeedView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct FeedView: View {

    // MARK: Variables

    @ObservedObject var viewModel = FeedViewModel()

    // MARK: - Body

    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 32) {
                    ForEach(viewModel.currentPhotoData) { photo in
                        NavigationLink {
                            PhotoDetailView(photo: photo)
                        } label: {
                            PhotoItemView(photo: photo)
                                .frame(width: 420, height: 420)
                        }
                        .buttonStyle(.card)
                    }
                }
                .padding([.bottom, .horizontal], 64)
                .padding(.top, 32)
            }
            .onAppear {
                Task {
                    await viewModel.fetchPhotos()
                }
            }
        }
        .task(refreshTask)
    }

    @Sendable
    private func refreshTask() {
        Task {
            await viewModel.fetchPhotos()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(viewModel: FeedViewModel())
    }
}
