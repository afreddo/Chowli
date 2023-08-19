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
    @State private var showLandmarkSheet = false
    
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    localSearchService.search(query: search)
                    showLandmarkSheet.toggle()
                }
                .padding()
            
//            if !localSearchService.landmarks.isEmpty {
//                LandmarkListView()
//            }
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(color: .black, radius: 1)
                        .foregroundColor(localSearchService.landmark == landmark ? .green : .red)
                        .scaleEffect(localSearchService.landmark == landmark ? 2 : 1)
                    
                    if localSearchService.landmark == landmark {
                        Text(landmark.name)
                            .fixedSize()
                            .foregroundColor(.green)
                            .shadow(color: .black, radius: 1)
                    }
                }
            }
        }
        .sheet(isPresented: $showLandmarkSheet) {
            LandmarkSheetView()
                .presentationDetents([.fraction(0.33)])
                .presentationBackgroundInteraction(
                    .enabled(upThrough: .medium)
                )
        }
        
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
