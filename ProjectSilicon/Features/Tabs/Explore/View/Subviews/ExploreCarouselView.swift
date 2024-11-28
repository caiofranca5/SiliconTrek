//
//  ExploreCarouselView.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

struct ExploreCarouselView: View {
    @EnvironmentObject var viewModel: ExploreViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                let landmarks = viewModel.landmarks
                
                ForEach(landmarks, id: \.self) { landmark in
                    Button(action: {
                        viewModel.navigationPath.append(landmark)
                    }) {
                        CarouselCell(screenSize: UIScreen.main.bounds.size, landmark: landmark)
                    }
                }
                Spacer().frame(width: 24)
            }
            .offset(x: 16)
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
            AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                image.resizable()
            } placeholder: {
                Color.init(uiColor: .systemGray5)
                    .frame(width: abs(screenSize.width/imageProportion), height: abs(screenSize.width/imageProportion)/1.5)
            }
            .scaledToFit()
            .frame(width: abs(screenSize.width/imageProportion), height: abs(screenSize.width/imageProportion)/1.5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(landmark.category.rawValue.uppercased())
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(landmark.category.tintColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            Text(landmark.name)
                .foregroundStyle(Color.primary)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .padding(.bottom, 8)
            
            Text(landmark.city.rawValue)
                .font(.system(size: 15, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.secondary)
        })
    }
}


#Preview {
    ExploreView()
}
