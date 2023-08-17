//
//  MKCoordinateRegion-Extension.swift
//  Chowli
//
//  Created by Alex Freddo on 8/16/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
    
}
