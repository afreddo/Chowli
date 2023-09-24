//
//  MapSearchView-ViewModel.swift
//  Chowli
//
//  Created by Alex Freddo on 9/24/23.
//

import Foundation
import SwiftUI

extension MapSearchView {
    @MainActor class ViewModel: ObservableObject {
        @Published var search: String = ""
        
        @Published var showLandmarkSheet = false
        @Published var showingLocationEditorSheet = false
        
        @Published var selectedLocationName = ""
        @Published var selectedLocationAddress = ""
    }
}
