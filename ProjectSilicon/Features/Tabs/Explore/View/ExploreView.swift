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
        NavigationStack(path: $viewModel.path, root: {
            GeometryReader(content: { geometry in
                ScrollView(content: {
                    VStack(spacing: 0, content: {
                        ExploreSearchBarView(viewModel: viewModel)
                        .padding(.bottom, 32)
                        .padding(.horizontal, 16)
                        
                        ExploreCategoriesView(viewModel: viewModel, categories: viewModel.homeCategories)
                            .padding(.bottom, 32)
                        
                        VStack(spacing: 0, content: {
                            
                            HStack(content: {
                                Text("Editors' Choice")
                                    .foregroundStyle(Color.primary)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.navigateToSearch(type: .all)
                                }, label: {
                                    Text("See All")
                                        .foregroundStyle(Color.accentColor)
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
                                    .foregroundStyle(Color.primary)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.navigateToSearch(type: .all)
                                }, label: {
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
                    .navigationDestination(for: SearchType.self) { destination in
                        SearchView(exploreViewModel: viewModel, type: destination)
                    }
                    .onAppear {
                        viewModel.searchText = ""
                    }
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
