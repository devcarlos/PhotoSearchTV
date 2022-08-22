//
//  FeedViewModel.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class FeedViewModel: ObservableObject {

    // MARK: Properties

    var feedData: FlickrFeed?
    private var service: FeedServiceProtocol?

    // MARK: - API

    init(service: FeedServiceProtocol? = FeedService()) {
        self.service = service
    }

    func fetchFeed() async {
        do {
            guard let data = try await service?.fetchFeed() else {
                return
            }
            self.feedData = data
        } catch let error {
            print(error)
        }
    }
}
