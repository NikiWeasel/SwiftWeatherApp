//
//  AppRoute.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Foundation

enum AppRoute: Hashable {
    case search
    case weatherDetails(cityID: Int)
}
