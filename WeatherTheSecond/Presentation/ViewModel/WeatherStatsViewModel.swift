//
//  WeatherStatsViewModel.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import Combine
import Foundation

@MainActor
final class WeatherStatsViewModel: ObservableObject {
    // MARK: - Published properties

    @Published var weather: WeatherEntity?
    @Published var error: AppError?
    @Published var isLoading: Bool = false
    @Published var timerValue: TimeInterval = 0 // сколько секунд прошло

    private var timerCancellable: AnyCancellable?

    var currentCity: String = "Moscow"
    private var hasLoadedInitially = false

    // MARK: - Dependencies

    private let weatherStatsUseCaseProtocol: WeatherStatsUseCaseProtocol

    var onShowSearchView: (() -> Void)?

    // MARK: - Init

    init(weatherStatsUseCaseProtocol: WeatherStatsUseCaseProtocol) {
        self.weatherStatsUseCaseProtocol = weatherStatsUseCaseProtocol
        startTimer()
    }

    // MARK: - Timer

    private func startTimer() {
        // обновляем каждую секунду
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.timerValue += 1

                // вызываем refreshWeather каждый 3600 секунд (1 час)
                if Int(self.timerValue) % 3600 == 0 {
                    self.timerValue = 0
                    Task { await self.refreshWeather() }
                }
            }
    }

    deinit {
        timerCancellable?.cancel()
    }

    // MARK: - Actions

    func loadWeather(for city: String) async {
        isLoading = true
        defer { isLoading = false }

        currentCity = city

        switch await weatherStatsUseCaseProtocol.execute(city: city) {
        case let .success(weather):
            self.weather = weather
        case let .failure(error):
            self.error = error
        }
    }

    func refreshWeather() async {
        isLoading = true
        defer {
            isLoading = false
            timerValue = 0
        }

        switch await weatherStatsUseCaseProtocol.execute(city: currentCity) {
        case let .success(weather):
            self.weather = weather
        case let .failure(error):
            isLoading = false
            self.error = error
        }
    }

    func showSearchView() {
        onShowSearchView?()
    }

    func loadInitialIfNeeded() {
        guard !hasLoadedInitially else { return }
        hasLoadedInitially = true

        Task {
            await refreshWeather()
        }
    }
}
