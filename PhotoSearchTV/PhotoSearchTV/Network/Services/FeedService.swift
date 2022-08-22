//
//  PhotoService.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Foundation

protocol FeedServiceProtocol: AnyObject {
    func fetchFeed() async throws -> FlickrFeed
}

class FeedService : FeedServiceProtocol {
    func fetchFeed() async throws -> FlickrFeed {
        let (data, _) = try await URLSession.shared.data(from: feedURL())

        return try JSONDecoder().decode(FlickrFeed.self, from: data)
    }

    private func feedURL() -> URL {
        var url = Constants.feedsUrl

        url = url.replacingOccurrences(of: "API_KEY", with: Constants.API_KEY)

        print("url \(url)")
        return URL(string: url)!
    }
}
