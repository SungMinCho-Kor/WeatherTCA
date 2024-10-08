//
//  WeatherFeature.swift
//  WeatherTCA
//
//  Created by 조성민 on 10/8/24.
//

import ComposableArchitecture
import CoreLocation
import WeatherKit
import UIKit

@Reducer
struct WeatherFeature {
    
    
    @ObservableState
    struct State: Equatable {
        
        var locationPermissionGranted: Bool = false
        var locationManager: LocationManager = LocationManager()
        var weathers: [Weather] = []
        
    }
    
    enum Action {
        
        case checkLocationPermission
        case goSetting
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .checkLocationPermission:
                if let status = state.locationManager.locationStatus {
                    switch status {
                    case .authorizedAlways, .authorizedWhenInUse:
                        state.locationPermissionGranted = true
                    default:
                        state.locationPermissionGranted = false
                    }
                } else {
                    state.locationPermissionGranted = false
                }
                return .none
            case .goSetting:
                if let status = state.locationManager.locationStatus {
                    switch status {
                    case .authorizedAlways, .authorizedWhenInUse:
                        state.locationPermissionGranted = true
                    default:
                        state.locationPermissionGranted = false
                    }
                } else {
                    state.locationPermissionGranted = false
                }
                
                if !state.locationPermissionGranted, let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    print("설정으로 이동 불가")
                }
                return .send(.checkLocationPermission)
            default:
                return .none
            }
        }
    }
    
}
