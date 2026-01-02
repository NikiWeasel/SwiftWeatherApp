//
//  SearchCityViewModel.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import Combine
import Foundation

@MainActor
final class SearchCityViewModel: ObservableObject {
    // MARK: - Published properties

    @Published var cities: [CityEntity]?
    @Published var error: AppError?
    @Published var isLoading: Bool = false

    // MARK: - Dependencies

    private let searchCityUseCaseProtocol: SearchCityUseCaseProtocol

    var onCitySelected: ((CityEntity) -> Void)?

    // MARK: - Init

    init(searchCityUseCaseProtocol: SearchCityUseCaseProtocol) {
        self.searchCityUseCaseProtocol = searchCityUseCaseProtocol
    }

    // MARK: - Actions

    func searchCity(for query: String) async {
        isLoading = true
        defer { isLoading = false }

        switch await searchCityUseCaseProtocol.execute(query: query) {
        case let .success(weather):
            cities = weather
        case let .failure(error):
            self.error = error
        }
    }

    func selectCity(
        _ city: CityEntity
    ) {
        onCitySelected?(city)
    }
}
