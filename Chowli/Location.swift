//
//  Location.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation
import MapKit

struct Location: Codable {
    
    let name: String
    let lat: Int
    let long: Int
    let comments: String
    let rating: Int
    let type: String
    let source: UUID
    
}
