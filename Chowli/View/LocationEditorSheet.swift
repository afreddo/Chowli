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
    @EnvironmentObject var dc: DataController
    
    @StateObject var vm = ViewModel()
    
    let geoCoder = CLGeocoder()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $vm.name)
                TextField("Address", text: $vm.address)
                
                Picker("Cuisine Type", selection: $vm.type) {
                    ForEach(vm.types, id: \.self) {
                        Text($0)
                    }
                }
            }
            .onChange(of: vm.address) { address in
                vm.convertAddress()
            }
            Section {
                TextEditor(text: $vm.comments)
                RatingView(rating: $vm.rating)
            } header: {
                Text("Write a Review")
            }
            
            Section {
                Button("Submit") {
                    vm.addLocation(dataController: dc)
                    dismiss()
                }
                .disabled(vm.isDisabled)
            }
        }
        .navigationTitle("Add Restaurant")
        
    }
}
