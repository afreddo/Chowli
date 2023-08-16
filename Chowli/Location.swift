//
//  Location.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation
import MapKit

struct Location: Codable {
    
    let address: String
    let name: String
    let lat: Double
    let long: Double
    let comments: String
    let rating: Int
    let type: String
    
}
