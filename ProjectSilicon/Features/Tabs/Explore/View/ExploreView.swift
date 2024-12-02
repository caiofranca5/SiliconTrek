//
//  HomeView.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import SwiftUI

struct ExploreView: View {
    
    var viewModel = ExploreViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack(path: $viewModel.navigationPath, root: {
            GeometryReader(content: { geometry in
                ScrollView(content: {
                    VStack(spacing: 0, content: {
                        Divider()
                        
                        ExploreSearchBarView()
                            .padding(.top, 24)
                            .padding(.bottom, 32)
                            .padding(.horizontal, 16)
                        
                        ExploreCategoriesView(categories: viewModel.homeCategories)
                            .padding(.bottom, 32)
                        
                        HStack(content: {
                            Text("Editors' Choice")
                                .foregroundStyle(Color.primary)
                                .font(.system(size: 20, weight: .semibold))
                            
                            Spacer()
                            
                            Button(action: {
                                //viewModel.navigateToSearch(type: .all)
                            }, label: {
                                Text("See All")
                                    .foregroundStyle(Color.accentColor)
                                    .font(.system(size: 17, weight: .medium))
                            })
                            
                        })
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16)
                        
                        ExploreCarouselView()
                        
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 24)
                        
                        HStack(content: {
                            Text("Top Rated")
                                .foregroundStyle(Color.primary)
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
                            let landmarks = viewModel.landmarks
                            
                            ForEach(landmarks, id: \.self) { landmark in
                                Button(action: {
                                    viewModel.navigationPath.append(landmark)
                                }) {
                                    LandmarkListCellView(screenSize: geometry.size, landmark: landmark)
                                }
                            }
                        })
                        
                        Divider().opacity(0)
                            .padding(16)
                        
                    })
                    .navigationTitle("Explore")
                    .navigationBarTitleDisplayMode(.large)
                    .navigationDestination(for: Landmark.self) { landmark in
                        LandmarkDetailView(landmark: landmark)
                    }
                    .navigationDestination(for: LandmarkCategory.self) { category in
                        CategoryDetailView(category: category)
                    }
                    .onAppear(perform: {
                        viewModel.loadLandmarks()
                    })
                })
            })
        })
        .environment(viewModel)
    }
}

#Preview {
    ContentView()
        .environment(ExploreViewModel())
}
