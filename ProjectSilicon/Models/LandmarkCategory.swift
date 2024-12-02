//
//  LandmarkCategory.swift
//  ProjectSilicon
//
//  Created by Caio França on 06/04/24.
//

import Foundation
import SwiftUI

enum LandmarkCategory: String, CaseIterable, Decodable, Identifiable, Hashable {
    case education = "Edu"
    case history = "History"
    case tech = "Tech"
    case nature = "Nature"
    case sports = "Sports"
    case recreation = "Recreation"
    case shopping = "Shopping"
    case dining = "Dining"
    
    var id: Int {
        switch self {
        case .education:
            return 1
        case .history:
            return 2
        case .tech:
            return 3
        case .nature:
            return 4
        case .sports:
            return 5
        case .recreation:
            return 6
        case .shopping:
            return 7
        case .dining:
            return 8
        }
    }
    
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
