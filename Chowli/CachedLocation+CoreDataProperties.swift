//
//  CachedLocation+CoreDataProperties.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//
//

import Foundation
import CoreData


extension CachedLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedLocation> {
        return NSFetchRequest<CachedLocation>(entityName: "CachedLocation")
    }
    
    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var comments: String?
    @NSManaged public var rating: Int16
    @NSManaged public var type: String?
    @NSManaged public var source: UUID?
    
    var wrappedAddress: String {
        address ?? ""
    }
    
    var wrappedName: String {
        name ?? ""
    }
    
    var wrappedComments: String {
        comments ?? "No comments"
    }
    
    var wrappedType: String {
        type ?? ""
    }

}

extension CachedLocation : Identifiable {

}
