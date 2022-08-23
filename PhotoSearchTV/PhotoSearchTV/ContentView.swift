//
//  ContentView.swift
//  PhotoSearchTV
//
//  Created by Carlos Alcala on 20/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FeedView()
                .edgesIgnoringSafeArea(.horizontal)
                .tabItem {
                    Label("Feed", systemImage: "")
                }
                    .tag("feed")

            SearchTabView()
                .tabItem {
                    Label("Search", systemImage: "")
                }
                .tag("search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

////        GeometryReader { geometry in
//            ScrollView(.vertical) {
//                VStack {
//                    VStack(alignment: .leading) {
//                        ForEach(0..<100) {
//                            Text("Row \($0)")
//                                .focusable()
//                        }
//                    }
////                    ForEach (0..<20) { _ in
////                        ListItem()
////                    }
//                }
//            } // Scrollview
////        } // GeometryReader
//struct ListItem: View {
////    let geometry: GeometryProxy
//
//    var body: some View {
//        Image("test")
//        .frame(height: 200)
//        .aspectRatio(contentMode: .fit)
//        .clipped()
//    }
//}
