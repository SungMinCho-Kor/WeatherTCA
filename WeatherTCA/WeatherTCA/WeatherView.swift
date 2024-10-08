//
//  WeatherView.swift
//  WeatherTCA
//
//  Created by 조성민 on 10/8/24.
//

import SwiftUI
import WeatherKit
import ComposableArchitecture

struct WeatherView: View {
    
    @Bindable var store: StoreOf<WeatherFeature>
    
    var body: some View {
        NavigationView {
            VStack {
                if store.locationPermissionGranted {
                    Image(systemName: "network")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("permission granted!")
                } else {
                    Image(systemName: "network.slash")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button {
                        store.send(.goSetting)
                    } label: {
                        Text("위치 권한 설정으로 이동")
                    }
                }
            }
            .navigationTitle("🌥️ 기상 상태")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .onAppear {
            store.send(.checkLocationPermission)
        }
    }
}

#Preview {
    WeatherView(
        store: Store(
            initialState: WeatherFeature.State(),
            reducer: {
                WeatherFeature()
            }
        )
    )
}
