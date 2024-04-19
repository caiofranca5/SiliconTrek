//
//  ExploreCategoriesView.swift
//  ProjectSilicon
//
//  Created by Caio França on 06/04/24.
//

import SwiftUI

struct ExploreCategoriesView: View {
    @ObservedObject var viewModel: ExploreViewModel
    let categories: [LandmarkCategory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 24, content: {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        viewModel.navigateToSearch(type: .category)
                        viewModel.categoryFilter = category
                    }, label: {
                        CategoryIconView(category: category)
                    })
                }
                
                Spacer().frame(width: 24)
            })
            .offset(x: 24)
        })
    }
}

fileprivate struct CategoryIconView: View {
    
    let category: LandmarkCategory
    
    var body: some View {
        VStack(content: {
            ZStack(content: {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(category.tintColor)
                    .frame(width: 60, height: 60)
                
                Image(systemName: category.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .semibold))
            })
            
            Text(category.rawValue)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.primary)
        })
    }
}

#Preview {
    CategoryIconView(category: .history)
}
