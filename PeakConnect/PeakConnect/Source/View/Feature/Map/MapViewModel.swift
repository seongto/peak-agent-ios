//
//  MapViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import Foundation
import NMapsMap

class MapViewModel {
    var currentLocation: NMGLatLng = NMGLatLng(lat: 37.5665, lng: 126.9780)
    
    var leadCoordinates: [NMGLatLng] {
        [
            NMGLatLng(lat: currentLocation.lat + 0.001, lng: currentLocation.lng + 0.001),
            NMGLatLng(lat: currentLocation.lat - 0.001, lng: currentLocation.lng - 0.001),
            NMGLatLng(lat: currentLocation.lat, lng: currentLocation.lng + 0.0015)
        ]
    }
    
    func createLeadMarkers() -> [NMFMarker] {
        leadCoordinates.map {
            let marker = NMFMarker(position: $0)
            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "flag.fill")!)
            marker.width = 40
            marker.height = 40
            marker.anchor = CGPoint(x: 0.5, y: 1.0)
            return marker
        }
    }
}
