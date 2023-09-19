//
//  LandmarkListView.swift
//  Chowli
//
//  Created by Alex Freddo on 8/16/23.
//

import SwiftUI
import MapKit

struct LandmarkListView: View {
    @EnvironmentObject var localSearchService: LocalSearchService
    
    var body: some View {

        List(localSearchService.landmarks) { landmark in
            VStack(alignment: .leading) {
                Text(landmark.name)
                Text(landmark.title)
                    .opacity(0.5)
            }
            .listRowBackground(localSearchService.landmark == landmark ? Color.secondary : Color.black)
            
            .onTapGesture {
                localSearchService.landmark = landmark
                withAnimation {
                    localSearchService.region = MKCoordinateRegion.regionFromLandmark(landmark)
                }
            }
            
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView().environmentObject(LocalSearchService())
    }
}
