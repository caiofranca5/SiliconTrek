//
//  HomeView.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import SwiftUI

struct ExploreView: View {
    
    @StateObject var viewModel = ExploreViewModel()

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
                            
                            TextField("Search", text: $viewModel.searchText)
                                .background(Color.init(uiColor: .systemGray6))
                                .font(.system(size: 17, weight: .regular))
                                .frame(height: 38)
                            
                        })
                        .padding(8)
                        .background(Color.init(uiColor: .systemGray6))
                        .clipShape(Capsule())
                        .padding(.bottom, 32)
                        .padding(.horizontal, 16)
                        
                        ExploreCategoriesView(categories: viewModel.homeCategories)
                            .padding(.bottom, 32)
                        
                        VStack(spacing: 0, content: {
                            
                            HStack(content: {
                                Text("Editors' Choice")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    Text("See All")
                                        .font(.system(size: 17, weight: .medium))
                                })
                                
                            })
                            .padding(.top, 24)
                            .padding(.bottom, 22)
                            .padding(.horizontal, 16)
                            
                            ExploreCarouselView(landmarks: viewModel.loadLandmarks(), selectedLandmark: $viewModel.selectedLandmark)
                                .padding(.bottom, 22)
                            
                            Divider()
                                .padding(.horizontal, 16)
                                .padding(.bottom, 24)
                            
                            HStack(content: {
                                Text("Top Rated")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    Text("See All")
                                        .font(.system(size: 17, weight: .medium))
                                })
                                
                            })
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                            
                            VStack(spacing: 24, content: {
                                ForEach(viewModel.loadLandmarks().prefix(2), id: \.self) { landmark in
                                    Button(action: {
                                        viewModel.selectedLandmark = landmark
                                    }, label: {
                                        LandmarkCellView(screenSize: geometry.size, landmark: landmark)
                                    })
                                }
                                
                                Divider().opacity(0)
                            })
                            
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
        .sheet(item: $viewModel.selectedLandmark) { selected in
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
