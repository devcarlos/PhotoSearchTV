//
//  Feed.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import Foundation
import SwiftDate

// MARK: - Feed Result

struct FlickrFeed: Codable {
    let title: String?
    let linkpage: String?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [FeedItem]
}

// MARK: - Feed
struct FeedItem: Codable {
    var title: String?
    var link: String?
    var media: FeedMedia
    var dateTaken: String?
    var description: String??
    var published: String?
    var author: String?
    var authorId: String?
    var tags: String?

    private enum CodingKeys : String, CodingKey {
        case title, link, media, dateTaken = "date_taken", description, published, author, authorId = "author_id", tags
    }
}

// MARK: - Feed Media

struct FeedMedia: Codable {
    let link: String
    
    private enum CodingKeys : String, CodingKey {
        case link = "m"
    }
}

extension FeedItem {
    var imageURL: URL? {
        return URL(string: media.link)
    }
    
    var subTitle: String {
        return (author ?? "") + " / " + (dateFormatted ?? "")
    }
    
    var dateFormatted: String? {
        return (dateTaken ?? "").toDate()?.toFormat("MMM dd yyyy")
    }
}
