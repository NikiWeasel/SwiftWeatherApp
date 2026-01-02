//
//  AppCoordinator.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Observation
import SwiftUI

struct AppCoordinator: View {
    @StateObject private var router: AppRouter

    @StateObject private var searchViewModel: SearchCityViewModel
    @StateObject private var weatherViewModel: WeatherStatsViewModel

    init(container: DIContainer) {
        let router = AppRouter()
        _router = StateObject(wrappedValue: router)

        let searchVM = SearchCityViewModel(
            searchCityUseCaseProtocol: container.searchCityUseCase
        )

        let weatherVM = WeatherStatsViewModel(
            weatherStatsUseCaseProtocol: container.fetchWeatherUseCase
        )

        _searchViewModel = StateObject(wrappedValue: searchVM)
        _weatherViewModel = StateObject(wrappedValue: weatherVM)

        // weak теперь КОРРЕКТЕН
        searchVM.onCitySelected = { [weak router] city in
            router?.navigateTo(
                route: .weatherDetails(cityID: city.id)
            )
        }

        weatherVM.onShowSearchView = { [weak router] in
            router?.navigateTo(route: .search)
        }
    }

    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            WeatherStatsView(viewModel: weatherViewModel)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .search:
                        SearchCityView(viewModel: searchViewModel)

                    case let .weatherDetails(cityID):
                        WeatherStatsView(viewModel: weatherViewModel)
                            .task {
                                await weatherViewModel
                                    .refreshWeather()
                            }
                    }
                }
        }
        .environmentObject(router)
        .environmentObject(searchViewModel)
        .environmentObject(weatherViewModel)

//        .environmentObject(weatherViewModel)
//        ...environmentObject(SearchCityViewModel)
    }
}
