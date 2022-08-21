//
//  FeedViewModel.swift
//  PhotoSearchTV
//
//  Created by Mac Mini on 20/8/22.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class FeedViewModel: ObservableObject {

    // MARK: Properties

    var currentPhotoData: [Photo]
    private var service: ServiceProtocol?

    // MARK: - API

    init(service: ServiceProtocol? = PhotoService()) {
        self.service = service
    }

    func fetchPhotos() async {
        do {
            let data = try await service?.getPhotos()
            self.currentPhotoData = data
        } catch let error {
            print(error)
        }
    }
}
