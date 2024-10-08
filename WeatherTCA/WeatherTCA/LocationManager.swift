//
//  LocationManager.swift
//  WeatherTCA
//
//  Created by 조성민 on 10/8/24.
//

import CoreLocation
import UIKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func dealAuthorizationUpdate() {
        switch locationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            print("Location Permission Requested First Time")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Authorized")
            // TODO: 위 계층으로 Authorized 됐다는 사실을 알려야 함.
        default:
            print("Denied")
            break
        }
    }
    
    // 권한 상태가 변경될 때 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        dealAuthorizationUpdate()
    }

    // 위치 업데이트 시 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locations.last
    }
    
}
