//
//  DIContainer.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Foundation

final class DIContainer {
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""

    // Network
    lazy var apiClient = APIClient()

    // Services
    lazy var weatherService: WeatherProviding = WeatherService(api: apiClient)

    // Repositories
    lazy var weatherRepository: WeatherFetching =
        RestRepository(service: weatherService, apiKey: apiKey)

    // UseCases
    lazy var searchCityUseCase: SearchCityUseCaseProtocol =
        SearchCityUseCase(repository: weatherRepository)

    lazy var fetchWeatherUseCase: WeatherStatsUseCaseProtocol =
        WeatherStatsUseCase(repository: weatherRepository)
}
