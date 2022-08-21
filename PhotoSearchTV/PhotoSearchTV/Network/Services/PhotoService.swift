//
//  PhotoService.swift
//  PhotoSearchTV
//
//  Created by Mac Mini on 20/8/22.
//

import Foundation

protocol ServiceProtocol: AnyObject {
    func getPhotos() async throws -> [Photo]
    func search() async throws -> [Photo]
}

class PhotoService : ServiceProtocol {
    func getPhotos() async throws -> [Photo] {
        let (data, _) = try await URLSession.shared.data(from: generateURL())

        let decodedData = try JSONDecoder().decode([Photo].self, from: data)
        return decodedData
    }
    
    func search(for query: String) async throws -> [Photo] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func generateURL() -> URL {
        var url = Constants.baseUrl
        url += "channelPageSize=3"
        url += "&contentPageSize=10"
        url += "&filterChannelTypes=true"

        print("url \(url)")
        return URL(string: url)!
    }
    
    private func generateSearchURL() -> URL {
        var url = Constants.baseUrl
        url += "channelPageSize=3"
        url += "&contentPageSize=10"
        url += "&filterChannelTypes=true"
        print("url \(url)")
        return URL(string: url)!
    }
}
