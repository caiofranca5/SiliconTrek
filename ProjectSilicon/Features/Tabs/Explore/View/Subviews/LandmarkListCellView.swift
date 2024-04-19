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
        HStack(spacing: 0, content: {
            AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/thumbnail")) { image in
                image.resizable()
            } placeholder: {
                Color.init(uiColor: .systemGray5)
                    .frame(width: abs(screenSize.width/3), height: abs(screenSize.width/3)/1.5)
            }
            .scaledToFit()
            .frame(width: abs(screenSize.width/3), height: abs(screenSize.width/3)/1.5)
            
            VStack(spacing: 8, content: {
                Text(landmark.name)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                
                HStack(spacing: 8, content: {
                    Image("place.fill")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color.accentColor)
                    
                    Text(landmark.city.rawValue)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color.secondary)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            .padding()
            .frame(height: abs(screenSize.width/3)/1.5)
            .background(Color.init(uiColor: .systemBackground))
        })
        .frame(width: abs(screenSize.width-32))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView()
}
