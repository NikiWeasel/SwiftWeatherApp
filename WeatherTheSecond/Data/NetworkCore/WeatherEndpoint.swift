//
//  WeatherEndpoint.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import Foundation

enum WeatherEndpoint: Endpoint {
    case searchCity(key: String, query: String)
    case currentWeather(key: String, city: String, lang: String)

    var path: String {
        switch self {
        case .searchCity:
            return "search.json"
        case .currentWeather:
            return "current.json"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .searchCity(key, query):
            return [
                .init(name: "key", value: key),
                .init(name: "q", value: query),
            ]

        case let .currentWeather(key, city, lang):
            return [
                .init(name: "key", value: key),
                .init(name: "q", value: city),
                .init(name: "lang", value: lang),
            ]
        }
    }
}
