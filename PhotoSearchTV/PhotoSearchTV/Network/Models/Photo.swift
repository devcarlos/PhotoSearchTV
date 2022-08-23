//
//  Photo.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 21/8/22.
//

import Foundation

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
}

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
