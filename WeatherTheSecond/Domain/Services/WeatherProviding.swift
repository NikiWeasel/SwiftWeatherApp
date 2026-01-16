//
//  WeatherProviding.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

protocol WeatherProviding: Sendable {
    func searchCity(
        key: String,
        cityQuery: String
    ) async throws -> [CitySearchDto]

    func fetchWeather(
        key: String,
        city: String,
        lang: String
    ) async throws -> WeatherResponseDto
}
