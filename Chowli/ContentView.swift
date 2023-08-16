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
    @StateObject private var user = User()
    @State private var showAddProfile = false
    @State private var profileName = "New User"
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
                        .frame(maxWidth: 50)
                        .shadow(radius: 1)
                        .offset(x: -20, y: -20)
                        .onTapGesture {
                            showingLocationEditorSheet.toggle()
                        }
                        
                }
                    .tabItem {
                        Label("My map", systemImage: "map.circle")
                    }
                Text("New Locations from Google API")
                    .tabItem {
                        Label("Location Finder", systemImage: "magnifyingglass.circle")
                    }
                RestaurantsVisitedView()
                    .tabItem {
                        Label("My Locations", systemImage: "list.bullet.circle")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if user.profile.name == Profile.newProfile.name {
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .onTapGesture {
                                showAddProfile = true
                            }
                        
                    } else {
                        NavigationLink {
                            ProfileView()
                        } label: {
                            Image(systemName: "person.circle")
                        }
                    }
                }
            }
            .alert("Create Profile Name", isPresented: $showAddProfile) {
                TextField("New User", text: $profileName)
                Button("OK") { }
            }
            .onChange(of: profileName) { profileName in
                user.changeName(name: profileName)
            }
            .sheet(isPresented: $showingLocationEditorSheet) {
                LocationEditorSheet()
                    .presentationDetents([.medium])
            }
            .navigationTitle("Chowli")
            .navigationBarTitleDisplayMode(.inline)
            .font(.headline)

        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
