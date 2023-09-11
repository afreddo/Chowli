//
//  LocationEditorSheet-ViewModel.swift
//  Chowli
//
//  Created by Alex Freddo on 9/11/23.
//

import Foundation
import SwiftUI
import MapKit

extension LocationEditorSheet {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var address = ""
        @Published var convertedAddress: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        @Published var name = ""
        @Published var comments = ""
        @Published var rating = 3
        @Published var type = "American"
        
        let geoCoder = CLGeocoder()
        
        var isDisabled: Bool {
            address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || convertedAddress.latitude == 0.0
        }
        
        let types = ["American", "Mexican", "Barbecue", "Chinese", "Thai", "Indian", "Brunch", "Steakhouse", "Italian", "Sushi", "Pizza", "Seafood", "Japanese", "French", "Other"]
        
        func addLocation(dataController: DataController) {
            dataController.addLocation(name: name, lat: convertedAddress.latitude, long: convertedAddress.longitude, comments: comments, rating: rating, type: type, address: address)
        }
        
        func convertAddress() {
            geoCoder.geocodeAddressString(address) { placemarks, error in
                guard
                    let placemark = placemarks,
                    let location = placemark.first?.location
                else { return }
                
                self.convertedAddress = location.coordinate
            }
        }
    }
}
