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
    let stat: String?
    let photos: PhotosPage
}

struct PhotosPage: Codable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Photo]

//    private enum CodingKeys : String, CodingKey {
//        case page, pages, perpage, total, photos = "photo"
//    }
}

//"photo" : [
//  {
//    "owner" : "195041273@N07",
//    "secret" : "1bb972eabf",
//    "server" : "65535",
//    "id" : "52303430056",
//    "farm" : 66,
//    "title" : "Promoções imperdíveis para quem quer viajar para São Paulo, Salvador, Beto Carrero World e Chapada Diamantina!",
//    "isfriend" : 0,
//    "isfamily" : 0,
//    "ispublic" : 1
//  },

// MARK: - Photo
struct Photo: Codable, Identifiable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
}

extension Photo {
    var serverURL: String {
        var url = Constants.imageUrl
        
        url = url.replacingOccurrences(of: "{SERVER_ID}", with: server ?? "")
        url = url.replacingOccurrences(of: "{PHOTO_ID}", with: id ?? "")
        url = url.replacingOccurrences(of: "{SECRET}", with: secret ?? "")
        url = url.replacingOccurrences(of: "{FORMAT}", with: "jpg")
    
        return url
    }

    var imageURL: URL? {
        return URL(string: serverURL)
    }
}
