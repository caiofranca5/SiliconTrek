//
//  ContentView.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var initialMapPosition: MapCameraPosition = .region(MKCoordinateRegion(center:
            .init(latitude: 37.332801, longitude: -122.030098), latitudinalMeters: 33000, longitudinalMeters: 33000))
    
    func loadLandmarks() -> [Landmark] {
        // Find the URL for the landmarks.json file in the main bundle
        guard let url = Bundle.main.url(forResource: "landmarks", withExtension: "json") else {
            fatalError("Failed to find landmarks.json in the bundle1.")
        }

        // Attempt to load the file into a Data object
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load landmarks.json from the bundle.2")
        }

        // Attempt to decode the JSON into an array of Landmark objects
        let decoder = JSONDecoder()
        guard let landmarks = try? decoder.decode([Landmark].self, from: data) else {
            fatalError("Failed to decode landmarks.json from the bundle.3")
        }

        return landmarks
    }
    
    var body: some View {
        Map(position: $initialMapPosition, interactionModes: .all) {
            ForEach(loadLandmarks(), id: \.name) { landmark in
                Marker(landmark.name, systemImage: landmark.category.icon, coordinate: landmark.coordinate)
                    .tint(landmark.category.tintColor)
                
                
//                Annotation("", coordinate: landmark.coordinate) {
//                    ZStack(content: {
//                        ZStack {
//                            Triangle()
//                                .frame(width: 12, height: 12)
//                                .rotationEffect(.degrees(-180))
//                                .offset(y: 15)
//                            
//                            Circle()
//                                .frame(width: 30, height: 30)
//                        }
//                        .foregroundStyle(landmark.tintColor)
//                        
//                        Image(systemName: landmark.icon)
//                            .foregroundStyle(.white)
//                            .font(.system(size: 15, weight: .semibold))
//                    })
//                }
                
            }
        }
        .mapStyle(.standard(elevation: .flat,
                            pointsOfInterest: .including([]),
                            showsTraffic: false))
        .mapControlVisibility(.hidden)
    }
}

#Preview {
    MapView()
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
