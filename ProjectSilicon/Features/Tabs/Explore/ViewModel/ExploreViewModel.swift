//
//  ExploreViewModel.swift
//  ProjectSilicon
//
//  Created by Caio França on 07/04/24.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var landmarks: [Landmark] = []
    
    let homeCategories: [LandmarkCategory] = [.tech, .nature, .history, .education, .sports, .shopping, .dining, .recreation]

    func loadLandmarks(){
        do {
            guard let url = Bundle.main.url(forResource: "landmarks", withExtension: "json") else {
                throw NSError(domain: "ExploreViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "Landmarks data file not found."])
            }

            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let landmarks = try decoder.decode([Landmark].self, from: data)
            self.landmarks = landmarks
        } catch {
            self.errorMessage = "Error loading landmarks: \(error.localizedDescription)"
        }
    }
}
