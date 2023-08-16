//
//  RestaurantDetailView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: CachedLocation
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .bottomTrailing) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    Text(author)
                        .foregroundColor(.white)
                        .background(Color.secondary)
                        .opacity(0.8)
                        .offset(x: -30, y: -5)
                }
            }
            .navigationTitle(restaurant.wrappedName)
        }
    }
    
    var image: String {
        switch restaurant.wrappedType {
        case "American":
            return "ilya-mashkov-American"
        case "Mexican":
            return "spencer-davis-Mexican"
        case "Barbecue":
            return "luis-santoyo-Barbecue"
        case "Chinese":
            return "sj-Chinese"
        case "Thai":
            return "emy-Thai"
        case "Indian":
            return "amirali-mirhashemian-Indian"
        case "Brunch":
            return "cera-Brunch"
        case "Steakhouse":
            return "nanxi-wei-Steakhouse"
        case "Italian":
            return "sorin-popa-Italian"
        case "Sushi":
            return "andraz-lazic-Sushi"
        case "Pizza":
            return "saahil-khatkhate-Pizza"
        case "Seafood":
            return "ca-creative-Seafood"
        case "Japanese":
            return "diego-lozano-Japanese"
        case "French":
            return "tommaso-urli-French"
        default:
            return "alyssa-kowalski-Other"
        }
    }
    
    var author: String {
        switch restaurant.wrappedType {
        case "American":
            return "Ilya Mashkov"
        case "Mexican":
            return "Spencer Davis"
        case "Barbecue":
            return "Luis Santoyo"
        case "Chinese":
            return "SJ"
        case "Thai":
            return "Emy"
        case "Indian":
            return "Amirali Mirhashemian"
        case "Brunch":
            return "Cera"
        case "Steakhouse":
            return "Nanxi Wei"
        case "Italian":
            return "Sorin Popa"
        case "Sushi":
            return "Andraz Lazic"
        case "Pizza":
            return "Saahil KhatKhate"
        case "Seafood":
            return "CA Creative"
        case "Japanese":
            return "Diego Lozano"
        case "French":
            return "Tommaso Urli"
        default:
            return "Alyssa Kowalski"
        }
    }
}
