//
//  LandmarkDetail.swift
//  ProjectSilicon
//
//  Created by Caio França on 04/04/24.
//

import SwiftUI
import MapKit

struct LandmarkDetailView: View {
    @Environment(ExploreViewModel.self) private var viewModel
    @Environment(\.openURL) var openURL
    @State var isRedacted: Bool = false
    let landmark: Landmark
   
    
    init(landmark: Landmark) {
        self.landmark = landmark
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(content: {
                VStack(spacing: 0, content: {
                    Divider()
                        .padding(.bottom)
                    
                    AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.init(uiColor: .systemGray5)
                            .frame(width: abs(geometry.size.width - 32), height: abs(geometry.size.width - 32)/1.5)
                    }
                    .scaledToFit()
                    .frame(width: abs(geometry.size.width - 32), height: abs(geometry.size.width - 32)/1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Text(landmark.name)
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 22, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                    
                    StarsView(fontSize: 15, voteAverage: 4.5, voteCount: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    Button(action: {}, label: {
                        Label("Add to My Journey", systemImage: "location.fill")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 6)
                    })
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(16)
                    
                    HStack(spacing: 12) {
                        Text(landmark.city.rawValue)
                        
                        Text("•")
                        
                        Text(landmark.category.rawValue)
                        
                        Text("•")
                        
                        Text(landmark.isPublic ? "Open to Visitors" : "Exterior View Only")
                    }
                    .foregroundColor(.secondary)
                    .font(.system(size: 15, weight: .semibold))
                    
                    Text(landmark.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.primary)
                        .padding(16)
                    
                    Divider()
                        .padding(.horizontal, 16)
                    
                    HStack(content: {
                        Text("Address")
                            .foregroundStyle(Color.primary)
                            .font(.system(size: 20, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Label("Get Directions", systemImage: "arrow.triangle.turn.up.right.circle")
                                .font(.system(size: 17, weight: .medium))
                        })
                        
                    })
                    .padding(16)
                    
                    Text(landmark.address + ", \(landmark.city.rawValue)")
                        .foregroundStyle(Color.secondary)
                        .font(.system(size: 17, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                                        
                    Divider()
                        .padding(16)
                    
                    Text("Extra")
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    HStack(spacing: 16, content: {
                        Button(action: {
                            openURL(URL(string: landmark.name)!)
                        }, label: {
                            Label("Learn More", systemImage: "safari.fill")
                                .font(.system(size: 17, weight: .medium))
                                .frame(height: 28)
                        })
                        .buttonStyle(.bordered)
                        
                        Button(action: {
                            openURL(URL(string: landmark.name)!)
                        }, label: {
                            Label("Review", systemImage: "star.bubble")
                                .font(.system(size: 17, weight: .medium))
                                .frame(height: 28)
                        })
                        .buttonStyle(.bordered)
                        
                        Menu {
                        } label: {
                            Label("Collections", systemImage: "folder.badge.plus")
                                .font(.system(size: 17, weight: .medium))
                                .symbolRenderingMode(.multicolor)
                                .frame(height: 28)
                                .labelStyle(.iconOnly)
                        }
                        .buttonStyle(.bordered)
                        
                        Spacer()
                    })
                    .padding(16)
                    
                    Spacer().frame(height: 8)
                })
            })
            .background(Color(.siliconBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                LandmarkDetailToolbar(landmark: landmark)
            })
//            .redacted(reason: isRedacted == false ? .placeholder : [])
        })
    }
}

#Preview {
    NavigationStack(root: {
        LandmarkDetailView(landmark: Landmark(id: 1, name: "Apple Infinite Loop", category: .tech, image: "211d33ce-fd6d-4879-070f-37bf77b9ab00", city: .cupertino, address: "1 Infinite Loop", latitude: 37.331669, longitude: -122.030098, description: "Apple’s classic corporate campus, a centerpiece of Silicon Valley’s tech landscape, known for its sleek architecture and proximity to Apple’s history and innovation.", isPublic: true))
            .environment(ExploreViewModel())
    })
}

struct LandmarkDetailToolbar: ToolbarContent {
    
    var landmark: Landmark
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            ///Add to Collection
            Menu {
            } label: {
                Image(systemName:"folder.badge.plus")
                    .symbolRenderingMode(.multicolor)
            }
            
            ///Share
            ShareLink(item: URL(string: "https://www.silicontrek.com/\(landmark.id)")!, label: {
                Image(systemName: "square.and.arrow.up")
            })
        }
        
    }
}
