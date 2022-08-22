//
//  PhotoService.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import Foundation
import Alamofire

protocol FeedServiceProtocol: AnyObject {
    func fetchFeed() async throws -> FlickrFeed
}

class FeedService : FeedServiceProtocol {
    func fetchFeed() async throws -> FlickrFeed {
        return try await withUnsafeThrowingContinuation { continuation in
            AF.request(feedURL(), parameters:nil, encoding: JSONEncoding.default).response { response in
                debugPrint("Response: \(response.result)")

                switch response.result {
                case .success(let jsonData):
                    let JSON = response.data?.prettyPrintedJSONString ?? ""
                    debugPrint("JSON \(String(describing: JSON))")
                    debugPrint(JSON)

                    guard let feed = try? JSONDecoder().decode(FlickrFeed.self, from: jsonData ?? Data()) else {
                        debugPrint("Unable to parse Feed")
                        return
                    }
                    print("feed \(String(describing: feed))")

                    continuation.resume(returning: feed)
                    return
                case let .failure(error):
                    print(error)
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    private func feedURL() -> URL {
        var url = Constants.feedsUrl

        url = url.replacingOccurrences(of: "API_KEY", with: Constants.API_KEY)

        print("url \(url)")
        return URL(string: url)!
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
