//
//  ExploreSearchBarView.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

struct ExploreSearchBarView: View {
    @Environment(ExploreViewModel.self) private var viewModel
    
    var body: some View {
        
        @Bindable var viewModel = viewModel
        
        HStack(spacing: 8, content: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondary.opacity(0.5))
                .padding(.leading, 8)
            
            TextField("Search", text: $viewModel.searchText)
                .background(Color.init(uiColor: .systemGray6))
                .font(.system(size: 17, weight: .regular))
                .frame(height: 38)
                .submitLabel(.search)
            
        })
        .padding(8)
        .background(Color.init(uiColor: .systemGray6))
        .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
