//
//  RestaurantDetailView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

struct RestaurantDetailView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dc: DataController
    @StateObject var vm = ViewModel()
    
    var restaurant: CachedLocation
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    Text(restaurant.wrappedAddress)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .contextMenu {
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = restaurant.wrappedAddress
                            } label: {
                                Label("Copy to clipboard", systemImage: "doc.on.doc")
                            }
                        }
                    
                    ZStack (alignment: .bottomTrailing) {
                        Image(vm.getImage(for: restaurant))
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                        Text("Credit: \(vm.getAuthor(for: restaurant))")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.secondary.opacity(0.8))
                            .clipShape(Capsule())
                            .offset(x: -30, y: -5)
                    }
                    
                    RatingView(rating: .constant(Int(restaurant.rating)))
                        .font(.largeTitle)
                    
                    Text(restaurant.wrappedComments)
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem {
                    Image(systemName: "trash.circle.fill")
                        .onTapGesture {
                            vm.showDeleteConfirmation.toggle()
                        }
                }
            }
            .alert("Are you sure you want to delete \(restaurant.wrappedName)?", isPresented: $vm.showDeleteConfirmation) {
                Button("Confirm", role: .destructive) {
                    vm.removeRestaurant(restaurant, dataController: dc)
                    dismiss()
                }
                Button("Cancel", role: .cancel) { }
            }
            .navigationTitle("\(restaurant.wrappedName): \(restaurant.wrappedType)")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
