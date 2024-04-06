//
//  LandmarkDetail.swift
//  ProjectSilicon
//
//  Created by Caio França on 04/04/24.
//

import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 0, content: {
                ZStack(alignment: .topTrailing, content: {
                    AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.init(uiColor: .systemGray5)
                            .frame(width: abs(geometry.size.width), height: abs(geometry.size.width)/1.5)
                    }
                    .scaledToFit()
                    .frame(width: abs(geometry.size.width), height: abs(geometry.size.width)/1.5)
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        ZStack(content: {
                            Circle()
                                .foregroundStyle(Color.black.opacity(0.4))
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .font(.system(size: 15, weight: .semibold))
                        })
                    })
                    .padding()
                })
                
                VStack(spacing: 16, content: {
                    Text(landmark.name)
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 22, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                    
                    HStack(spacing: 8, content: {
                        Image("place.fill")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.accentColor)
                        
                        Text(landmark.city.rawValue)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(Color.secondary)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    Text("About")
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("The Apple Campus is the former corporate headquarters of Apple Inc. from 1993 until 2017. In April 2017, it was largely replaced by Apple Park (aka Apple Campus 2), but is still an Apple office and lab space. The campus is located at 1 Infinite Loop in Cupertino, California, United States.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            
                            Label("Start Journey", systemImage: "figure.walk")
                                .font(.system(size: 17, weight: .semibold))
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        
                    })
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                })
                .padding(.horizontal, 16)
                .background(Color.init(uiColor: .systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(y: -20)
            })
        })
    }
}

#Preview {
    LandmarkDetailView(landmark: Landmark(id: 1, name: "Apple Infinite Loop", category: .tech, image: "211d33ce-fd6d-4879-070f-37bf77b9ab00", city: .cupertino, address: "1 Infinite Loop", latitude: 37.331669, longitude: -122.030098))
}
