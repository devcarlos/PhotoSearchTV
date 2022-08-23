//
//  PhotoService.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Foundation
import Alamofire

protocol PhotoServiceProtocol: AnyObject {
    func search(with query: String) async throws -> SearchResult
}

class PhotoService : PhotoServiceProtocol {
    func search(with query: String) async throws -> SearchResult {
        guard let url = searchURL(with: query) else {
            return SearchResult(stat: "", photos: PhotosPage(page: 0, pages: 0, perpage: 0, total: 0, photo: []))
        }
        
        return try await withUnsafeThrowingContinuation { continuation in
            AF.request(url, parameters:nil, encoding: JSONEncoding.default).response { response in
                debugPrint("Response: \(response.result)")

                switch response.result {
                case .success(let jsonData):
                    let JSON = response.data?.prettyPrintedJSONString ?? ""
                    debugPrint("JSON \(String(describing: JSON))")
                    debugPrint(JSON)

                    guard let searchResult = try? JSONDecoder().decode(SearchResult.self, from: jsonData ?? Data()) else {
                        debugPrint("Unable to parse SearchResult")
                        return
                    }
                    print("searchResult: \(String(describing: searchResult))")

                    continuation.resume(returning: searchResult)
                    return
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    private func searchURL(with query: String) -> URL? {
        var url = Constants.searchUrl

        url = url.replacingOccurrences(of: "API_KEY", with: Constants.API_KEY)
        let queryText = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        url = url.replacingOccurrences(of: "SEARCH_TEXT", with: queryText)

        print("TEXT \(queryText)")
        print("URL SEARCH \(url)")
        return URL(string: url)
    }
}
