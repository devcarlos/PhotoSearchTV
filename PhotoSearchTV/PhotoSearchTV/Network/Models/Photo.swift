//
//  Photo.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import Foundation

//{
//    "photos": {
//        "page": 1,
//        "pages": 6089,
//        "perpage": 100,
//        "total": 608834,
//        "photo": [
//            {
//                "id": "32445815994",
//                "owner": "26849514@N06",
//                "secret": "685544f61a",
//                "server": "712",
//                "farm": 1,
//                "title": "Grote Knip, Curaçao",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },
//            {
//                "id": "51704493639",
//                "owner": "26849514@N06",
//                "secret": "206f959784",
//                "server": "65535",
//                "farm": 66,
//                "title": "Galleria Umberto I, Naples, Italy",
//                "ispublic": 1,
//                "isfriend": 0,
//                "isfamily": 0
//            },


// MARK: - Photos Data Models

struct SearchResult: Codable {
    let photos: [PhotosPage]
}

struct PhotosPage: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int
    var title: String?
    var ispublic: Bool
    var isfriend: Bool
    var isfamily: Bool
}
