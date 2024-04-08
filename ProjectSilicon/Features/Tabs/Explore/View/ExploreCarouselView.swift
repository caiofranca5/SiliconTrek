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
    let imageProportion = 1.5
    @State var isBookmarked = false
    
    var body: some View {
        VStack(spacing: 0, content: {
            ZStack(alignment: .topLeading, content: {
                
                AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                    image.resizable()
                } placeholder: {
                    Color.init(uiColor: .systemGray5)
                        .frame(width: abs(screenSize.width/imageProportion), height: abs(screenSize.width/imageProportion)/1.5)
                }
                .scaledToFit()
                .frame(width: abs(screenSize.width/imageProportion), height: abs(screenSize.width/imageProportion)/1.5)
                    
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
                    
                    Button(action: {isBookmarked.toggle()}, label: {
                        ZStack(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.primary.opacity(0.6))
                                .frame(width: 40, height: 40)
                            
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 17, weight: .semibold))
                        })
                    })
                })
                .padding()
                .frame(width: abs(screenSize.width/imageProportion))
                
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
            .frame(width: abs(screenSize.width/imageProportion), height: 80)
            .background(Color.init(uiColor: .systemBackground))
        })
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 2)
    }
}


#Preview {
    ExploreView()
}
