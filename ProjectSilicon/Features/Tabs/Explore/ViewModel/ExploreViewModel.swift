//
//  ExploreViewModel.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var searchText = ""
    @Published var searchCategory: LandmarkCategory = .dining
    
    @Published var selectedCity: LandmarkCity = .all
    @Published var selectedLandmark: Landmark?
    @Published var errorMessage: String?
    
    let homeCategories: [LandmarkCategory] = [.tech, .nature, .history, .education, .sports, .shopping, .dining, .recreation]

    func loadLandmarks() -> [Landmark] {
        do {
            guard let url = Bundle.main.url(forResource: "landmarks", withExtension: "json") else {
                throw NSError(domain: "ExploreViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Landmarks data file not found."])
            }

            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let landmarks = try decoder.decode([Landmark].self, from: data)
            return landmarks
        } catch {
            self.errorMessage = "Error loading landmarks: \(error.localizedDescription)"
            return []
        }
    }
    
    func navigateToSearch(type: SearchType) {
        path.append(type)
    }
    
}
