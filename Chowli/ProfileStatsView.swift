//
//  ProfileStatsView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

struct ProfileStatsView: View {
    @EnvironmentObject private var user: User
        
    var body: some View {
        Group {
            VStack {
                Text("Location Visited")
                    .font(.caption.bold())
                Text("\(user.getLocationsCount())")
                    .font(.title3)
            }
            
            VStack {
                Text("Favorite Cuisine")
                    .font(.caption.bold())
                // Need to have way to filter type and display here
                Text("American")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProfileStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileStatsView()
    }
}
