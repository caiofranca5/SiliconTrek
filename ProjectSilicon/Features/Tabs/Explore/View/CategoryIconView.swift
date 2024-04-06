//
//  CategoryIconView.swift
//  ProjectSilicon
//
//  Created by Caio França on 06/04/24.
//

import SwiftUI

struct CategoryIconView: View {
    
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
