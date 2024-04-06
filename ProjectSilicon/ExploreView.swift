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
                                        CategoryIconView(title: category.rawValue, icon: category.icon, color: category.tintColor)
                                    })
                                }
                                
                                Spacer().frame(width: 24)
                            })
                            .offset(x: 24)
                        })
                        .padding(.bottom, 32)
                        
                        VStack(spacing: 32, content: {
                            
                            HStack(content: {
                                Text("Landmarks")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
//                                Menu(content: {
//                                    ForEach(LandmarkCity.allCases) { city in
//                                        Button(action: {
//                                            self.selectedCity = city
//                                        }) {
//                                            if self.selectedCity == city {
//                                                Label(city.rawValue, systemImage: "checkmark")
//                                            } else {
//                                                Label(city.rawValue, systemImage: "checkmark")
//                                                    .labelStyle(.titleOnly)
//                                            }
//                                        }
//                                    }
//                                }, label: {
//                                    HStack(alignment: .center, content: {
//                                        Text("See All")
//                                            .font(.system(size: 17, weight: .medium))
//                                            .foregroundStyle(Color.primary)
//                                        
//                                        Image(systemName: "chevron.right")
//                                            .font(.system(size: 15, weight: .semibold))
//                                            .foregroundStyle(Color.accentColor)
//                                    })
//                                    .padding(.horizontal, 16)
//                                    .padding(.vertical, 8)
//                                    .background(Color.init(uiColor: .systemBackground))
//                                    .clipShape(Capsule())
//                                })
                                
                                Button(action: {
                                    print("Oi")
                                }, label: {
                                    Text("See All")
                                })
                                
                            })
                            .padding(.top, 32)
                            .padding(.horizontal, 16)
                            
                            ForEach(loadLandmarks(), id: \.self) { landmark in

                                Button(action: {
                                    selectedLandmark = landmark
                                }, label: {
                                    LandmarkView(size: geometry.size, landmark: landmark)
                                })
                            }
                            
                            Spacer().frame(height: 0)
                            
                        })
                        .background(Color.init(uiColor: .systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    })
                    .padding(.top, 16)
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

struct CategoryIconView: View {
    
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(content: {
            ZStack(content: {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(color)
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .semibold))
            })
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.primary)
        })
    }
}

struct LandmarkView: View {
    
    let size: CGSize
    let landmark: Landmark
    
    var body: some View {
        VStack(spacing: 0, content: {
            ZStack(alignment: .topLeading, content: {
                
                AsyncImage(url: URL(string: "https://imagedelivery.net/4YLjfnQ2tjfhd2rW7LgU6g/\(landmark.image)/resized")) { image in
                    image.resizable()
                } placeholder: {
                    Color.init(uiColor: .systemGray5)
                        .frame(width: abs(size.width - 32), height: abs(size.width - 32)/1.5)
                }
                .scaledToFit()
                .frame(width: abs(size.width - 32), height: abs(size.width - 32)/1.5)
                    
                HStack(content: {
                    ZStack(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(landmark.category.tintColor)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: landmark.category.icon)
                            .foregroundStyle(.white)
                            .font(.system(size: 17, weight: .semibold))
                    })
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        ZStack(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.black.opacity(0.6))
                                .frame(width: 40, height: 40)
                            
                            Image(systemName: "bookmark")
                                .foregroundStyle(.white)
                                .font(.system(size: 17, weight: .semibold))
                        })
                    })
                    .padding()
                    
                })
                .frame(width: abs(size.width - 32))
                
                
            })
            
            VStack(spacing: 0, content: {
                Text(landmark.name)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                HStack(spacing: 8, content: {
                    Image("place.fill")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accentColor)
                    
                    Text(landmark.city.rawValue)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.secondary)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Spacer()
            })
            .frame(width: abs(size.width - 32), height: 88)
            .background(Color.init(uiColor: .systemBackground))
        })
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(radius: 2)
    }
}
