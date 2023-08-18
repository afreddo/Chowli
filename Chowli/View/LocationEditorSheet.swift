//
//  LocationEditorSheet.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI
import MapKit

struct LocationEditorSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var user: User
    
    @State private var address = ""
    @State private var convertedAddress: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var name = ""
    @State private var comments = ""
    @State private var rating = 3
    @State private var type = "American"
    
    let geoCoder = CLGeocoder()
    
    var isDisabled: Bool {
        address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || convertedAddress.latitude == 0.0
    }
    
    let types = ["American", "Mexican", "Barbecue", "Chinese", "Thai", "Indian", "Brunch", "Steakhouse", "Italian", "Sushi", "Pizza", "Seafood", "Japanese", "French", "Other"]
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Address", text: $address)
                
                Picker("Cuisine Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
            }
            .onChange(of: address) { address in
                convertAddress()
            }
            Section {
                TextEditor(text: $comments)
                RatingView(rating: $rating)
            } header: {
                Text("Write a Review")
            }
            
            Section {
                Button("Submit") {
                    addLocation(name: name, lat: convertedAddress.latitude, long: convertedAddress.longitude, comments: comments, rating: rating, type: type, address: address)
                    
                    dismiss()
                }
                .disabled(isDisabled)
            }
        }
        .navigationTitle("Add Restaurant")
        
    }
    func convertAddress() {
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard
                let placemark = placemarks,
                let location = placemark.first?.location
            else {
                print("error is \(error?.localizedDescription)")
                return
            }
            
            convertedAddress = location.coordinate
        }
    }
    
    func addLocation(name: String, lat: Double, long: Double, comments: String = "", rating: Int = 3, type: String, address: String) {

        let cachedLocation = CachedLocation(context: moc)
        cachedLocation.name = name
        cachedLocation.lat = lat
        cachedLocation.long = long
        cachedLocation.comments = comments
        cachedLocation.rating = Int16(rating)
        cachedLocation.type = type
        cachedLocation.address = address
        
        try? moc.save()
    }
}

struct LocationEditorSheet_Previews: PreviewProvider {
    static var previews: some View {
        LocationEditorSheet()
    }
}
