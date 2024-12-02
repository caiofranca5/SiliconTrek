//
//  LandmarkCellView.swift
//  ProjectSilicon
//
//  Created by Caio França on 06/04/24.
//

import SwiftUI

struct LandmarkListCellView: View {
    
    let screenSize: CGSize
    let landmark: Landmark
    
    var body: some View {
        HStack(alignment: .top, spacing: 0, content: {
            AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/thumbnail")) { image in
                image.resizable()
            } placeholder: {
                Color.init(uiColor: .systemGray5)
                    .frame(width: abs(screenSize.width/3.35), height: abs(screenSize.width/3.35)/1.5)
            }
            .scaledToFit()
            .frame(width: abs(screenSize.width/3.35), height: abs(screenSize.width/3.35)/1.5)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(spacing: 0, content: {
                HStack(alignment: .top, spacing: 0, content: {
                    VStack(spacing: 0, content: {
                        Text(landmark.name)
                            .foregroundStyle(Color.primary)
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.bottom, 8)
                        
                        Text(landmark.city.rawValue)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                    .padding(.leading, 16)
                    
//                    ZStack(content: {
//                        RoundedRectangle(cornerRadius: 6)
//                            .foregroundStyle(landmark.category.tintColor)
//                            .frame(width: 28, height: 28)
//                        
//                        Image(systemName: landmark.category.icon)
//                            .foregroundStyle(.white)
//                            .font(.system(size: 12, weight: .semibold))
//                    })
//                    .opacity(0)
                })
                
                Spacer()
                
                Divider()
                    .padding(.leading, 16)
            })
        })
        .frame(height: abs(screenSize.width/3.35)/1.5)
        .background(Color.init(uiColor: .systemBackground))
        .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}
