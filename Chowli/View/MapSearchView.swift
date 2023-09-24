//
//  MapSearchView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/16/23.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @StateObject private var vm = ViewModel()
    @EnvironmentObject var localSearchService: LocalSearchService
    
    var body: some View {
        VStack {
            if localSearchService.landmarks.isEmpty {
                TextField("Search", text: $vm.search)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.search)
                    .onSubmit {
                        localSearchService.search(query: vm.search)
                        vm.showLandmarkSheet.toggle()
                    }
                    .padding()
            } else {
                HStack {
                    TextField("Search", text: $vm.search)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.search)
                        .onSubmit {
                            localSearchService.search(query: vm.search)
                            vm.showLandmarkSheet.toggle()
                        }
                    Button("Cancel", role: .cancel) {
                        localSearchService.resetUI()
                        vm.search = ""
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
                            vm.selectedLocationName = landmark.name
                            vm.selectedLocationAddress = landmark.title
                            withAnimation {
                                localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                            }
                        }
                        .contextMenu {
                            Button("Add to My Locations") {
                                vm.showingLocationEditorSheet.toggle()
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
        .sheet(isPresented: $vm.showLandmarkSheet) {
            LandmarkSheetView()
                .presentationDetents([.fraction(0.33)])
                .presentationBackgroundInteraction(
                    .enabled(upThrough: .large)
                )
        }
        .sheet(isPresented: $vm.showingLocationEditorSheet) {
            LocationEditorSheetBound(address: vm.selectedLocationAddress, name: vm.selectedLocationName)
        }
        
    }
}

struct MapSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MapSearchView()
    }
}
