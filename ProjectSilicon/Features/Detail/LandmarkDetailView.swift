//
//  LandmarkDetail.swift
//  ProjectSilicon
//
//  Created by Caio França on 04/04/24.
//

import SwiftUI
import MapKit

struct LandmarkDetailView: View {
    let landmark: Landmark
    @State var isRedacted: Bool = false
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion()
    )
    
    init(landmark: Landmark) {
        self.landmark = landmark
        _cameraPosition = State(initialValue: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: landmark.latitude, longitude: landmark.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
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
                    
                    Button(action: {
                        
                    }, label: {
                        Label("Start Navigation", systemImage: "location.fill")
                            .font(.system(size: 17, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 4)
                    })
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(16)
                    
                    HStack(spacing: 12) {
                        Text(landmark.city.rawValue)
                        
                        Text("•")
                        
                        Text(landmark.category.rawValue)
                        
                        Text("•")
                        
                        Text("Private")
                    }
                    .foregroundColor(.secondary)
                    .font(.system(size: 15, weight: .semibold))
                    
                    Text("The Apple Campus is the former corporate headquarters of Apple Inc. from 1993 until 2017. In April 2017, it was largely replaced by Apple Park (aka Apple Campus 2), but is still an Apple office and lab space.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.primary)
                        .padding(16)
                    
                    Divider()
                        .padding(.horizontal, 16)
                    
                    Text("Address")
                        .foregroundStyle(Color.primary)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                    
                    Text(landmark.address + ", \(landmark.city.rawValue)")
                        .foregroundStyle(Color.secondary)
                        .font(.system(size: 17, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
//                    Map(position: $cameraPosition) {
//                        Marker(landmark.name, coordinate: CLLocationCoordinate2D(latitude: landmark.latitude, longitude: landmark.longitude))
//                    }
//                    .frame(width: abs(geometry.size.width - 32), height: abs(geometry.size.width - 32)/2)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.vertical, 16)
                    
                })
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                LandmarkDetailToolbar(landmark: landmark)
            })
//            .tint(.white)
//            .redacted(reason: isRedacted == false ? .placeholder : [])
        })
    }
}

#Preview {
    NavigationStack(root: {
        LandmarkDetailView(landmark: Landmark(id: 1, name: "Apple Infinite Loop", category: .tech, image: "211d33ce-fd6d-4879-070f-37bf77b9ab00", city: .cupertino, address: "1 Infinite Loop", latitude: 37.331669, longitude: -122.030098))
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
                    //.symbolRenderingMode(.multicolor)
            }
            
            ///Share
            ShareLink(item: URL(string: "https://www.silicontrek.com/\(landmark.id)")!, label: {
                Image(systemName: "square.and.arrow.up")
            })
        }
        
    }
}
