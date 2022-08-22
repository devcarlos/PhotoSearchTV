//
//  Feed.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import Foundation

//({
//        "title": "Recent Uploads tagged cats",
//        "link": "https:\/\/www.flickr.com\/photos\/tags\/cats\/",
//        "description": "",
//        "modified": "2022-08-21T08:07:38Z",
//        "generator": "https:\/\/www.flickr.com",
//        "items": [
//       {
//            "title": "Kaugummi",
//            "link": "https:\/\/www.flickr.com\/photos\/mickythepixel\/52300266388\/",
//            "media": {"m":"https:\/\/live.staticflickr.com\/65535\/52300266388_e52707b205_m.jpg"},
//            "date_taken": "2022-08-09T19:04:28-08:00",
//            "description":
//            "published": "2022-08-21T08:07:38Z",
//            "author": "nobody@flickr.com (\"micky the pixel\")",
//            "author_id": "7141646@N02",
//            "tags": "neunkirchen oberermarkt langenstrichstrase cennetmarkt lebensmittel nahrung food ern\u00e4hrung kaugummi bubblegum candy sweets fini packung cats saarland deutschland germany"
//       },


// MARK: - Feed Result

struct FlickrFeed: Codable {
    let title: String
    let linkpage: String
    let description: String
    let modified: String
    let generator: String
    let items: [FeedItem]
}

// MARK: - Feed
struct FeedItem: Codable {
    var title: String
    var link: String
    var media: String
    var dateTaken: String
    var description: String
    var published: String
    var author: String
    var authorId: String
    var tags: String

    private enum CodingKeys : String, CodingKey {
        case title, link, media, dateTaken = "date_taken", description, published, author, authorId = "author_id", tags
    }
}

extension FeedItem {
    var imageURL: URL? {
        return URL(string: link)
    }
}
