//
//  ProfileView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var user: User
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(50)
                HStack {
                    ProfileStatsView()
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
            }
        }
        .navigationTitle("\(user.profile.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
