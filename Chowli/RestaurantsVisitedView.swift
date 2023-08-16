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
    
    var body: some View {
        List {
            ForEach(locations) { location in
                HStack {
                    VStack {
                        Text(location.wrappedName)
                            .font(.headline)
                        Text(location.wrappedType)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    RatingView(rating: .constant(Int(location.rating)))
                        .font(.title3)
                }
            }
            .onDelete(perform: removeRestaurant)
            
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
