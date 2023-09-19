//
//  DataController.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Chowli")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
    func addLocation(name: String, lat: Double, long: Double, comments: String = "", rating: Int = 3, type: String, address: String) {

        let cachedLocation = CachedLocation(context: container.viewContext)
        cachedLocation.name = name
        cachedLocation.lat = lat
        cachedLocation.long = long
        cachedLocation.comments = comments
        cachedLocation.rating = Int16(rating)
        cachedLocation.type = type
        cachedLocation.address = address.uppercased()
        
        try? container.viewContext.save()
    }
    
    func removeLocation(_ restaurant: CachedLocation) {
        container.viewContext.delete(restaurant)
        
        try? container.viewContext.save()
    }
}
