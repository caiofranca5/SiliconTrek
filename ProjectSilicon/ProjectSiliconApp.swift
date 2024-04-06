//
//  ProjectSiliconApp.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import SwiftUI

@main
struct ProjectSiliconApp: App {
    var body: some Scene {
        WindowGroup {
           ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView(content: {
            ExploreView()
                .tabItem { Label("Explore", systemImage: "signpost.right.fill") }
            
            Text("Favorites")
                .tabItem { Label("Favorites", systemImage: "bookmark") }
            
            Text("You")
                .tabItem { Label("You", systemImage: "person") }
        })
    }
}

#Preview {
    ContentView()
}
