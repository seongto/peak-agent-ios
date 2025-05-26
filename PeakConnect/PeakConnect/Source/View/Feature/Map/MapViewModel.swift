//
//  MapViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import Foundation
import NMapsMap

class MapViewModel {
    
    // 현재 위치 좌표 (초기값 : 서울 중심)
    var currentLocation: NMGLatLng = NMGLatLng(lat: 37.5665, lng: 126.9780)
    
    // 리드 마커 좌표 (현재 위치 기준으로 임의로 위치 지정)
    var leadCoordinates: [NMGLatLng] {
        [
            NMGLatLng(lat: currentLocation.lat + 0.001, lng: currentLocation.lng + 0.001),
            NMGLatLng(lat: currentLocation.lat - 0.001, lng: currentLocation.lng - 0.001),
            NMGLatLng(lat: currentLocation.lat, lng: currentLocation.lng + 0.0015)
        ]
    }
}
