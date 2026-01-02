//
//  SearchCityView.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import SwiftUI

struct SearchCityView: View {
    @StateObject var viewModel: SearchCityViewModel
    @State private var searchText = ""
    @State private var searchTask: Task<Void, Never>?

    var body: some View {
        SearchView(cities: viewModel.cities)
            .navigationTitle(NSLocalizedString("search city", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            ).onChange(of: searchText) {
                searchTask?.cancel()
                searchTask = Task {
                    try? await Task.sleep(nanoseconds: 400_000_000)
                    await viewModel.searchCity(for: searchText)
                }
            }
    }
}
