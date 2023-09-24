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
    @State private var showingLocationEditorSheet = false
    
    @State private var selectedLocationName = ""
    @State private var selectedLocationAddress = ""
    
    var body: some View {
        VStack {
            if localSearchService.landmarks.isEmpty {
                TextField("Search", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.search)
                    .onSubmit {
                        localSearchService.search(query: search)
                        showLandmarkSheet.toggle()
                    }
                    .padding()
            } else {
                HStack {
                    TextField("Search", text: $search)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.search)
                        .onSubmit {
                            localSearchService.search(query: search)
                            showLandmarkSheet.toggle()
                        }
                    Button("Cancel", role: .cancel) {
                        localSearchService.resetUI()
                        search = ""
                    }
                }
                .padding()
            }
                
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
                        .onTapGesture {
                            localSearchService.landmark = landmark
                            selectedLocationName = landmark.name
                            selectedLocationAddress = landmark.title
                            withAnimation {
                                localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                            }
                        }
                        .contextMenu {
                            Button("Add to My Locations") {
                                showingLocationEditorSheet.toggle()
                            }
                        }
                    
                    if localSearchService.landmark == landmark {
                        VStack {
                            Text(landmark.name)
                                .font(.headline)
                                .fixedSize()
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 1)
                            Text(landmark.title)
                                .font(.subheadline)
                                .fixedSize()
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 1)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showLandmarkSheet) {
            LandmarkSheetView()
                .presentationDetents([.fraction(0.33)])
                .presentationBackgroundInteraction(
                    .enabled(upThrough: .large)
                )
        }
        .sheet(isPresented: $showingLocationEditorSheet) {
            LocationEditorSheetBound(address: selectedLocationAddress, name: selectedLocationName)
        }
        
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
