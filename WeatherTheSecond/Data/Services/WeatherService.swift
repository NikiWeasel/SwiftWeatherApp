//
//  WeatherService.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

actor WeatherService: WeatherProviding {
    let api: APIClient

    init(api: APIClient) {
        self.api = api
    }

    func fetchWeather(key: String, city: String, lang: String) async throws -> WeatherResponseDto {
        try await api.request(
            WeatherEndpoint.currentWeather(
                key: key,
                city: city,
                lang: lang
            )
        )
    }

    func searchCity(key: String, cityQuery: String) async throws -> [CitySearchDto] {
        try await api.request(
            WeatherEndpoint.searchCity(
                key: key,
                query: cityQuery
            )
        )
    }
}
