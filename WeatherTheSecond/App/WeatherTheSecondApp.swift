//
//  WeatherTheSecondApp.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import SwiftUI

@main
struct WeatherTheSecondApp: App {
    private let router = AppRouter()

    var body: some Scene {
        WindowGroup {
            let container = DIContainer()
            AppCoordinator(
                container: container
            )
        }
    }
}
