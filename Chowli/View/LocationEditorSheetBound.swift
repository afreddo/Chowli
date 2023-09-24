//
//  LocationEditorSheetBound.swift
//  Chowli
//
//  Created by Alex Freddo on 9/24/23.
//

import SwiftUI

import SwiftUI
import MapKit

struct LocationEditorSheetBound: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dc: DataController
    
    @State var address: String
    @State var name: String
    
    @State private var convertedAddress: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @State private var comments = ""
    @State private var rating = 3
    @State private var type = "American"
    
    var isDisabled: Bool {
        address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || convertedAddress.latitude == 0.0
    }
    
    let types = ["American", "Mexican", "Barbecue", "Chinese", "Thai", "Indian", "Brunch", "Steakhouse", "Italian", "Sushi", "Pizza", "Seafood", "Japanese", "French", "Other"]
    
    let geoCoder = CLGeocoder()
    
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
                    addLocation(dataController: dc)
                    dismiss()
                }
                .disabled(isDisabled)
            }
        }
        .navigationTitle("Add Restaurant")
        .onAppear {
            convertAddress()
        }
    }
    
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
