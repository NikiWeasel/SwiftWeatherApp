//
//  WeatherStatsUseCase.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

final class WeatherStatsUseCase: WeatherStatsUseCaseProtocol {
    private let repository: WeatherFetching

    init(repository: WeatherFetching) {
        self.repository = repository
    }

    func execute(city: String) async -> Result<WeatherEntity, AppError> {
        let result = await repository.fetchWeather(city: city)

        // здесь можно добавить бизнес-логику, кэширование, проверку правил
        switch result {
        case let .success(city):
            return .success(city)
        case let .failure(error):
            return .failure(error)
        }
    }
}
