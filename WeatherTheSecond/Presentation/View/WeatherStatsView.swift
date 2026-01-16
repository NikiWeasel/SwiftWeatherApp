//
//  WeatherStatsView.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import SwiftUI

struct WeatherStatsView: View {
    @StateObject var viewModel: WeatherStatsViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let weather = viewModel.weather {
                AnimatedGlassView(
                    viewModel: viewModel,
                    weather: weather
                )
                .navigationTitle(
                    "\(weather.location.name), \(weather.location.country)"
                )
                .navigationBarTitleDisplayMode(.inline) // Стиль отображения
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        Button(action: {
                            viewModel.showSearchView()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    })
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                await viewModel.refreshWeather()
                            }
                        }, label: { Image(systemName: "arrow.clockwise") })
                    }
                }
            } else {
                ProgressView().onAppear {
                    viewModel.loadInitialIfNeeded()
                }
            }

            if let error = viewModel.error {
                ContentUnavailableView {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .symbolEffect(.pulse)
                } description: {
                    Text(error.localizedDescription)
                } actions: {
                    Button("Retry") {
                        Task { await viewModel.loadWeather(for: "Moscow") }
                    }
                }
            }
        }
    }
}
