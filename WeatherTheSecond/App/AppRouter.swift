//
//  AppRouter.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Combine
import Foundation
import SwiftUI

final class AppRouter: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func navigateTo(route: AppRoute) {
        navigationPath.append(route)
    }

    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }
}
