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
                NavigationStack {
                    VStack {
                        Image(systemName: "exclamationmark.triangle").symbolEffect(.pulse)
                            .font(.system(size: 48))

                        Text("Error: \(error.localizedDescription)").font(.system(size: 20)).padding(2)

                        Button {
                            Task {
                                await viewModel.loadWeather(for: "Moscow")
                            }
                        } label: {
                            Text(NSLocalizedString("renew", comment: ""))
                        }
                    }
                }
            }
        }
    }
}
