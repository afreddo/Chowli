//
//  ContentView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingLocationEditorSheet = false
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CachedLocation>
 
    
    var body: some View {
        NavigationView {
            
            TabView {
                ZStack (alignment: .bottomTrailing) {
                    if locations.isEmpty {
                        UserMapView(startLocation: CLLocationCoordinate2DMake(37.7749, -122.4194))
                    } else {
                        UserMapView(startLocation: CLLocationCoordinate2D(latitude: locations.last?.lat ?? 0.0, longitude: locations.last?.long ?? 0.0))
                    }
                    
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(maxWidth: 75)
                        .shadow(radius: 1)
                        .offset(x: -20, y: -20)
                        .onTapGesture {
                            showingLocationEditorSheet.toggle()
                        }
                        
                }
                    .tabItem {
                        Label("My Map", systemImage: "map.circle")
                    }
                
                MapSearchView()
                    .tabItem {
                        Label("Location Finder", systemImage: "magnifyingglass.circle")
                    }
                
                RestaurantsVisitedView()
                    .tabItem {
                        Label("My Locations", systemImage: "list.bullet.circle")
                    }
            }
            .sheet(isPresented: $showingLocationEditorSheet) {
                LocationEditorSheet()
                    .presentationDetents([.medium])
            }
            .navigationTitle("Chowli")
            .navigationBarTitleDisplayMode(.inline)
            .font(.headline)

        }
        .onAppear {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
