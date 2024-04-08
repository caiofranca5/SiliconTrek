//
//  ExploreCarouselView.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

struct ExploreCarouselView: View {
    let landmarks: [Landmark]
    @Binding var selectedLandmark: Landmark?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(landmarks, id: \.self) { landmark in
                    Button(action: {
                        self.selectedLandmark = landmark
                    }) {
                        CarouselCell(screenSize: UIScreen.main.bounds.size, landmark: landmark)
                    }
                    .padding(.vertical, 2)
                }
                
                Spacer().frame(width: 24)
            }
            .offset(x: 24)
        }
    }
}

fileprivate struct CarouselCell: View {
    
    let screenSize: CGSize
    let landmark: Landmark
    
    var body: some View {
        VStack(spacing: 0, content: {
            ZStack(alignment: .topLeading, content: {
                
                AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                    image.resizable()
                } placeholder: {
                    Color.init(uiColor: .systemGray5)
                        .frame(width: abs(screenSize.width/1.5), height: abs(screenSize.width/1.5)/1.5)
                }
                .scaledToFit()
                .frame(width: abs(screenSize.width/1.5), height: abs(screenSize.width/1.5)/1.5)
                    
                    
                HStack(content: {
                    ZStack(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(landmark.category.tintColor)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: landmark.category.icon)
                            .foregroundStyle(.white)
                            .font(.system(size: 17, weight: .semibold))
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        ZStack(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.primary.opacity(0.6))
                                .frame(width: 40, height: 40)
                            
                            Image(systemName: "bookmark")
                                .foregroundStyle(.white)
                                .font(.system(size: 17, weight: .semibold))
                        })
                    })
                })
                .padding()
                .frame(width: abs(screenSize.width/1.5))
                
                
            })
            
            VStack(spacing: 8, content: {
                Text(landmark.name)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                
                HStack(spacing: 8, content: {
                    Image("place.fill")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accentColor)
                    
                    Text(landmark.city.rawValue)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.secondary)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            .padding()
            .frame(width: abs(screenSize.width/1.5), height: 80)
            .background(Color.init(uiColor: .systemBackground))
        })
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 2)
    }
}


//#Preview {
//    ExploreCarouselView()
//}
