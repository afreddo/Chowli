//
//  LandmarkSheetView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/19/23.
//

import SwiftUI
import MapKit

struct LandmarkSheetView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    @State private var showingLocationEditorSheet = false
    @State private var addedLocationName = ""
    @State private var addedLocationAddress = ""
    
    @State private var selectedLocationName = ""
    @State private var selectedLocationAddress = ""
    
    var body: some View {
        VStack {
            List(localSearchService.landmarks) { landmark in
                VStack(alignment: .leading) {
                    Text(landmark.name)
                    Text(landmark.title)
                        .opacity(0.5)
                }
                .listRowBackground(localSearchService.landmark == landmark ? Color.secondary : Color.black)
                .onTapGesture {
                    localSearchService.landmark = landmark
                    withAnimation {
                        localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                    }
                }
                .swipeActions {
                    Button("Add to My Locations") {
                        selectedLocationName = landmark.name
                        selectedLocationAddress = landmark.title
                    }
                    .tint(.green)
                }
                .contextMenu {
                    Button {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = landmark.title
                    } label: {
                        Label("Copy to clipboard", systemImage: "doc.on.doc")
                    }
                }
                .sheet(isPresented: $showingLocationEditorSheet) {
                    LocationEditorSheetBound(address: selectedLocationAddress, name: selectedLocationName)
                }
            }
            .onChange(of: selectedLocationName) { _ in
                showingLocationEditorSheet.toggle()
            }
        }
    }
}

struct LandmarkSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkSheetView()
    }
}
