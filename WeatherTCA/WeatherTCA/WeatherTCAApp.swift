//
//  WeatherTCAApp.swift
//  WeatherTCA
//
//  Created by 조성민 on 10/8/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct WeatherTCAApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(
                store: Store(
                    initialState: WeatherFeature.State(),
                    reducer: {
                        WeatherFeature()
                    }
                )
            )
        }
    }
}
