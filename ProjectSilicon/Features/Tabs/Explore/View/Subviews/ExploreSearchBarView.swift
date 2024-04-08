//
//  ExploreSearchBarView.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

struct ExploreSearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 8, content: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondary.opacity(0.5))
                .padding(.leading, 8)
            
            TextField("Search", text: $searchText)
                .background(Color.init(uiColor: .systemGray6))
                .font(.system(size: 17, weight: .regular))
                .frame(height: 38)
                .submitLabel(.search)
                .onSubmit {
                    print(searchText)
                }
            
        })
        .padding(8)
        .background(Color.init(uiColor: .systemGray6))
        .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
