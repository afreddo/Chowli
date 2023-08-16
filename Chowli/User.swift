//
//  User.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation
import CoreData
import SwiftUI
import MapKit

@MainActor class User: ObservableObject {
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CachedLocation>
    
    let geoCoder = CLGeocoder()
    let dataManager = DataManager()
    @Published var profile: Profile
    
    var locationsVisited: Int {
         return locations.count
    }
    
    init() {
        profile = dataManager.loadProfile()
    }
    
    func changeName(name: String) {
        objectWillChange.send()
        profile.changeName(name)
        saveProfile()
    }
    
    
    
    func saveProfile() {
        dataManager.saveProfile(profile)
    }
    
    func getID() -> UUID {
        profile.id
    }
    
    func getLocationsCount() -> Int {
        return locationsVisited
    }
    
    func getStartingCoords() -> CLLocationCoordinate2D {
        if locations.isEmpty {
            return CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        } else {
            return CLLocationCoordinate2D(latitude: Double(locations[-1].lat), longitude: Double(locations[-1].long))
        }
    }
}
