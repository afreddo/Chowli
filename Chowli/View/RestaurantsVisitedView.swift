//
//  RestaurantsVisitedView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI



struct RestaurantsVisitedView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var user: User
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CachedLocation>
    
    @State private var filterType = "All"
    @State private var searchText = ""
    @State private var showFilterSelector = false
    
    var types = ["All", "American", "Mexican", "Barbecue", "Chinese", "Thai", "Indian", "Brunch", "Steakhouse", "Italian", "Sushi", "Pizza", "Seafood", "Japanese", "French", "Other"]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: 300, height: 40)
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                    
                    Picker("Filter by cuisine", selection: $filterType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .frame(width: 250)
                    .foregroundColor(.primary)
                    .font(.headline)
                }
                .padding(10)
                
                
                List {
                    ForEach(locations) { location in
                        NavigationLink {
                            RestaurantDetailView(restaurant: location)
                        } label: {
                            HStack {
                                VStack {
                                    Text(location.wrappedName)
                                        .font(.headline)
                                    Text(location.wrappedType)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("\(location.rating)/5")
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            }
                        }
                    }
                    .onDelete(perform: removeRestaurant)
                }
                .searchable(text: $searchText, prompt: "Search for a restaurant")
                .onChange(of: [searchText, filterType]) { _ in
                    
                    let p1 = NSPredicate(format: "name CONTAINS %@", searchText)
                    let p2 = NSPredicate(format: "type CONTAINS %@", filterType)
                    
                    if searchText.isEmpty && filterType == "All" {
                        locations.nsPredicate = nil
                    } else if searchText.isEmpty {
                        locations.nsPredicate = p2
                    } else if filterType == "All" {
                        locations.nsPredicate = p1
                    } else {
                        let newPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1, p2])
                        locations.nsPredicate = newPredicate
                    }
                }
            }
        }
    }
    
    func removeRestaurant(at offsets: IndexSet) {
        for index in offsets {
            let restaurant = locations[index]
            moc.delete(restaurant)
        }
        
        try? moc.save()
    }
}

struct RestaurantsVisitedView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsVisitedView()
    }
}
