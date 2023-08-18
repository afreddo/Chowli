//
//  MapSearchView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/16/23.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @State private var search: String = ""
    @EnvironmentObject var localSearchService: LocalSearchService
    
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    localSearchService.search(query: search)
                }
                .padding()
            
            if localSearchService.landmarks.isEmpty {
                Text("Delicious places await you!")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
            } else {
                LandmarkListView()
            }
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(localSearchService.landmark == landmark ? .purple : .red)
                        .scaleEffect(localSearchService.landmark == landmark ? 2 : 1)
                }
            }
            
            Spacer()
        }
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
