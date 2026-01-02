//
//  SearchView.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 22.12.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherStatsViewModel
    @EnvironmentObject var router: AppRouter

    let cities: [CityEntity]?

    var body: some View {
        if let citiesList = cities {
            List(citiesList) { city in
                VStack(alignment: .leading) {
                    Text(city.name).font(.title3)
                    Text("\(city.region), \(city.country)")
                }
                .padding(8)
                .onTapGesture {
                    Task {
                        await viewModel.loadWeather(for: city.name)
                        router.navigationPath.removeLast()
                    }
                }
            }
        } else {
            VStack {
                Image(systemName: "tray")
                    .symbolEffect(.wiggle, options: .repeat(1))
                    .font(.system(size: 48))
                Text("Empty").font(.system(size: 20)).padding(2)
            }
        }
    }
}

#Preview {
//    SearchView(cities: [
//        CityEntity(id: 0, name: "Moscow", region: "Moscow City", country: "Russia"),
//        CityEntity(id: 0, name: "Moscow", region: "Moscow City", country: "Russia"),
//    ])

    VStack {
        Image(systemName: "tray")
            .symbolEffect(.wiggle, options: .repeat(1))
            .font(.system(size: 48))
        Text("Empty").font(.system(size: 20)).padding(2)
    }
}
