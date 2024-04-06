//
//  LandmarkCity.swift
//  ProjectSilicon
//
//  Created by Caio França on 06/04/24.
//

import Foundation

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
