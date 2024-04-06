//
//  Landmark.swift
//  ProjectSilicon
//
//  Created by Caio França on 02/04/24.
//

import Foundation
import SwiftUI
import MapKit

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
    
}

