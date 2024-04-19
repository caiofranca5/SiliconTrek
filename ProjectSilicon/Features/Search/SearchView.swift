//
//  SearchView.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

enum SearchType {
    case text
    case category
    case all
}

struct SearchView: View {
    @ObservedObject var exploreViewModel: ExploreViewModel
    let type: SearchType
    
    var body: some View {
        GeometryReader(content: { geometry in
            ScrollView(content: {
                VStack(spacing: 0, content: {
                    Divider()
                    
                    VStack(spacing: 24, content: {
                        Text("\(exploreViewModel.loadLandmarks().count) Results")
                            .font(.system(size: 17, weight: .medium))
                        
                        ForEach(exploreViewModel.loadLandmarks(), id: \.self) { landmark in
                            Button(action: {
                                exploreViewModel.selectedLandmark = landmark
                            }, label: {
                                LandmarkListCellView(screenSize: geometry.size, landmark: landmark)
                            })
                        }
                        
                        Divider().opacity(0)
                    })
                    .padding(.top, 24)
                    .background(Color.init(uiColor: .systemGray6))
                })
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Picker("All Cities", selection: $exploreViewModel.cityFilter) {
                            ForEach(LandmarkCity.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }
            })
        })
    }
}

#Preview {
    NavigationStack(root: {
        SearchView(exploreViewModel: ExploreViewModel(), type: .category)
    })
}

struct Previews_SearchView_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}
