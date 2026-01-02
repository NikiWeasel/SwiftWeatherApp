//
//  SearchCityUseCase.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

@MainActor
final class SearchCityUseCase: SearchCityUseCaseProtocol {
    private let repository: WeatherFetching

    init(repository: WeatherFetching) {
        self.repository = repository
    }

    func execute(query: String) async -> Result<[CityEntity],
        AppError>
    {
        let result = await repository.searchCity(query: query)

        // здесь можно добавить бизнес-логику, кэширование, проверку правил
        switch result {
        case let .success(city):
            return .success(city)
        case let .failure(error):
            return .failure(error)
        }
    }
}
