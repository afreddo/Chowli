//
//  RestaurantsVisitedView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

enum sortType {
    case noType, rating, alphabetical
}

struct RestaurantsVisitedView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var locations: FetchedResults<CachedLocation>
    
    @State private var filterType = "All"
    @State private var searchText = ""
    @State private var showFilterSelector = false
    
    @State private var sortType: sortType = .noType
    @State private var showConfirmationDialog = false
    
    var types = ["All", "American", "Mexican", "Barbecue", "Chinese", "Thai", "Indian", "Brunch", "Steakhouse", "Italian", "Sushi", "Pizza", "Seafood", "Japanese", "French", "Other"]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                HStack {
                    Image(systemName: sortType == .noType ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 40)
                        .foregroundColor(sortType == .noType ? .secondary : .blue)
                        .onTapGesture {
                            showConfirmationDialog.toggle()
                        }
                    ZStack {
                        Rectangle()
                            .frame(width: 300, height: 40)
                            .foregroundColor(filterType == "All" ? .secondary : .blue)
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
                }
                .padding(10)
                
                
                List {
                    ForEach(locations) { location in
                        NavigationLink {
                            RestaurantDetailView(restaurant: location)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(location.wrappedName)
                                            .font(.headline)
                                            .padding([.trailing], 10)
                                        Text(location.wrappedType)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    HStack {
                                        Text(location.wrappedAddress)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                            .padding([.leading], 10)
                                    }
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
                .onChange(of: sortType) { _ in
                    switch sortType {
                    case .alphabetical:
                        locations.sortDescriptors = [SortDescriptor(\.name)]
                    case .rating:
                        locations.sortDescriptors = [SortDescriptor(\.rating, order: .reverse)]
                    
                    default:
                        locations.sortDescriptors = []
                    }
                }
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
                .confirmationDialog("Sort method", isPresented: $showConfirmationDialog) {
                    Button("A-Z") { sortType = .alphabetical }
                    Button("Rating") { sortType = .rating }
                    Button("None") { sortType = .noType }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select sort type")
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
