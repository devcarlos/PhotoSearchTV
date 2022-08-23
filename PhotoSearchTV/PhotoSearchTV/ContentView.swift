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
