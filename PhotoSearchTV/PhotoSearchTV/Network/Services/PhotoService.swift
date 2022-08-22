//
//  PhotoService.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Foundation

protocol PhotoServiceProtocol: AnyObject {
    func search(with query: String) async throws -> SearchResult
}

class PhotoService : PhotoServiceProtocol {
    func search(with query: String) async throws -> SearchResult {
        let (data, _) = try await URLSession.shared.data(from: searchURL(with: query))

        return try JSONDecoder().decode(SearchResult.self, from: data)
    }

    private func searchURL(with query: String) -> URL {
        var url = Constants.searchUrl

        url = url.replacingOccurrences(of: "API_KEY", with: Constants.API_KEY)
        url = url.replacingOccurrences(of: "SEARCH_TEXT", with: query)

        print("url \(url)")
        return URL(string: url)!
    }
}
