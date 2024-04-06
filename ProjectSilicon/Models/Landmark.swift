//
//  Landmark.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import Foundation
import SwiftUI
import MapKit

enum LandmarkCategory: String, CaseIterable, Decodable {
    case education = "Edu"
    case history = "History"
    case tech = "Tech"
    case nature = "Nature"
    case sports = "Sports"
    case recreation = "Recreation"
    case shopping = "Shopping"
    case dining = "Dining"
    
    var icon: String {
        switch self {
        case .education:
            return "graduationcap.fill"
        case .tech:
            return "building.fill"
        case .history:
            return "building.columns.fill"
        case .nature:
            return "tree.fill"
        case .sports:
            return "football.fill"
        case .recreation:
            return "theatermasks.fill"
        case .shopping:
            return "bag.fill"
        case .dining:
            return "fork.knife"
        }
    }
    
    var tintColor: Color {
        switch self {
        case .education:
            return Color("SiliconPurple")
        case .tech:
            return Color("SiliconBlue")
        case .history:
            return Color("SiliconOrange")
        case .nature:
            return Color("SiliconGreen")
        case .sports:
            return Color("SiliconBrown")
        case .recreation:
            return Color("SiliconMint")
        case .shopping:
            return Color("SiliconRed")
        case .dining:
            return Color("SiliconYellow")
        }
    }
}

enum LandmarkCity: String, CaseIterable, Identifiable, Decodable {
    case all = "All Cities"
    case paloAlto = "Palo Alto"
    case menloPark = "Menlo Park"
    case mountainView = "Mountain View"
    case cupertino = "Cupertino"
    case santaClara = "Santa Clara"
    case sanJose = "San Jose"
    case losAltos = "Los Altos"
    
    var id: String { self.rawValue }
}

struct Landmark: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let category: LandmarkCategory
    let image: String
    let city: LandmarkCity
    let address: String
    let latitude: Double
    let longitude: Double

    enum CodingKeys: CodingKey {
        case id
        case name
        case category
        case image
        case city
        case address
        case latitude
        case longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var tintColor: Color {
        return category.tintColor
    }
    
    var icon: String {
        return category.icon
    }
    
}

