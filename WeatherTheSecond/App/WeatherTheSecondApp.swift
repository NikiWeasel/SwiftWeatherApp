//
//  WeatherTheSecondApp.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import SwiftUI

@main
struct WeatherTheSecondApp: App {
    @State private var container = DIContainer()
    private let router = AppRouter()

    var body: some Scene {
        WindowGroup {
            AppCoordinator(container: container)
        }
    }
}
