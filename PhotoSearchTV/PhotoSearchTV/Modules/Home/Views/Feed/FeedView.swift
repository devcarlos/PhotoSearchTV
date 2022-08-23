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
        PhotoFeedView(feed: viewModel.feedData)
        .onAppear {
            Task {
                await viewModel.fetchFeed()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(viewModel: FeedViewModel())
    }
}
