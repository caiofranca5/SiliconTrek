//
//  HomeView.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import SwiftUI

struct ExploreView: View {
    
    @State var searchText = ""
    @State private var selectedCity: LandmarkCity = .all
    let homeCategories: [LandmarkCategory] = [.tech, .nature, .history, .education, .sports, .shopping, .dining, .recreation]
    @State private var selectedLandmark: Landmark?

    // Assuming you have the Landmark struct and related enums as previously discussed

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
        NavigationStack(root: {
            GeometryReader(content: { geometry in
                ScrollView(content: {
                    VStack(spacing: 0, content: {
                        HStack(spacing: 8, content: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.secondary.opacity(0.5))
                                .padding(.leading, 8)
                            
                            TextField("Pesquisar", text: $searchText)
                                .background(Color.init(uiColor: .systemGray6))
                                .font(.system(size: 17, weight: .regular))
                                .frame(height: 38)
                            
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(Color.accentColor)
                                .padding(.trailing, 8)
                            
                        })
                        .padding(8)
                        .background(Color.init(uiColor: .systemGray6))
                        .clipShape(Capsule())
                        .padding(.bottom, 32)
                        .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack(spacing: 24, content: {
                                ForEach(homeCategories, id: \.self) { category in
                                    Button(action: {
                                        
                                    }, label: {
                                        CategoryIconView(category: category)
                                    })
                                }
                                
                                Spacer().frame(width: 24)
                            })
                            .offset(x: 24)
                        })
                        .padding(.bottom, 32)
                        
                        VStack(spacing: 0, content: {
                            
                            HStack(content: {
                                Text("Top Rated")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    print("Oi")
                                }, label: {
                                    Text("See All")
                                })
                                
                            })
                            .padding(.top, 24)
                            .padding(.bottom, 22)
                            .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                HStack(spacing: 24, content: {
                                    ForEach(loadLandmarks(), id: \.self) { landmark in
                                        Button(action: {
                                            selectedLandmark = landmark
                                        }, label: {
                                            LandmarkCellView(screenSize: geometry.size, landmark: landmark)
                                        })
                                        .padding(.vertical,2)
                                    }
                                    
                                    Spacer().frame(width: 24)
                                })
                                .offset(x: 24)
                            })
                            .padding(.bottom, 22)
                            
                        })
                        .background(Color.init(uiColor: .systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    })
                    .padding(.top, 24)
                    .navigationTitle("Explore")
                    .navigationBarTitleDisplayMode(.large)
                })
            })
        })
        .sheet(item: $selectedLandmark) { selected in
            LandmarkDetailView(landmark: selected)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .interactiveDismissDisabled()
        }
        
    }
}

#Preview {
    ContentView()
}



//Menu(content: {
//    ForEach(LandmarkCity.allCases) { city in
//        Button(action: {
//            self.selectedCity = city
//        }) {
//            if self.selectedCity == city {
//                Label(city.rawValue, systemImage: "checkmark")
//            } else {
//                Label(city.rawValue, systemImage: "checkmark")
//                    .labelStyle(.titleOnly)
//            }
//        }
//    }
//}, label: {
//    HStack(alignment: .center, content: {
//        Text("See All")
//            .font(.system(size: 17, weight: .medium))
//            .foregroundStyle(Color.primary)
//        
//        Image(systemName: "chevron.right")
//            .font(.system(size: 15, weight: .semibold))
//            .foregroundStyle(Color.accentColor)
//    })
//    .padding(.horizontal, 16)
//    .padding(.vertical, 8)
//    .background(Color.init(uiColor: .systemBackground))
//    .clipShape(Capsule())
//})
