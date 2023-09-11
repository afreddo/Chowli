//
//  ChowliApp.swift
//  Chowli
//
//  Created by Alex Freddo on 8/15/23.
//

import SwiftUI

@main
struct ChowliApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(LocalSearchService())
                .preferredColorScheme(.dark)
        }
    }
}
