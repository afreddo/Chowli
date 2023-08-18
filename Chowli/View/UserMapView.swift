//
//  UserMapView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI
import MapKit

struct UserMapView: View {
    @EnvironmentObject private var user: User
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CachedLocation>
    @State private var mapRegion: MKCoordinateRegion
    
    init(startLocation: CLLocationCoordinate2D) {
        _mapRegion = State(initialValue: MKCoordinateRegion(center: startLocation, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)))
        
    }
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)) {
                VStack {
                    NavigationLink {
                        RestaurantDetailView(restaurant: location)
                    } label: {
                        VStack {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 30, height: 30)
                                .background(.white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 1)
                            
                            Text(location.wrappedName).bold()
                                .fixedSize()
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 1)
                        }
                    }
                }
            }
        }
    }
}

