//
//  PhotoDetail.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 23/8/22.
//

import Foundation
import SwiftUI

struct PhotoDetail: View {

    let item: FeedItem

    var body: some View {
        VStack() {
            PhotoItemView(item: item)
                .focusable()
        }
    }
}
