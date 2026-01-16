//
//  DIContainer.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Foundation

@MainActor
final class DIContainer {
    let weatherRepository: WeatherFetching
    let searchCityUseCase: SearchCityUseCaseProtocol
    let fetchWeatherUseCase: WeatherStatsUseCaseProtocol

    init() {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
        let apiClient = APIClient()
        let weatherService = WeatherService(api: apiClient)

        let repository = RestRepository(service: weatherService, apiKey: apiKey)
        weatherRepository = repository

        searchCityUseCase = SearchCityUseCase(repository: repository)
        fetchWeatherUseCase = WeatherStatsUseCase(repository: repository)
    }
}
