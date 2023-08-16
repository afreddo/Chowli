//
//  Profile.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation
import MapKit

struct Profile: Codable, Identifiable, Equatable {
    
    let id: UUID
    var name: String
    
    static let newProfile = Profile(id: UUID(), name: "New User")
    
    mutating func changeName(_ name: String) {
        self.name = name
    }
}
