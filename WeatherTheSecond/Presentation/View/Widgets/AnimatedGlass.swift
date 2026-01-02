//
//  AnimatedGlass.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 19.12.2025.
//

import Foundation
import SwiftUI

struct AnimatedGlassView: View {
    @ObservedObject var viewModel: WeatherStatsViewModel

    let weather: WeatherEntity

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                AsyncImage(url: URL(string: weather.current.conditionIcon)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120).padding(16)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Text("\(String(format: "%.0f", weather.current.tempC))°С")
                    .font(.system(size: 80, weight: .bold))

                Text(weather.current.conditionText)
                    .font(.default).foregroundStyle(Color("Secondary")).padding(8)

                HStack {
                    StatContainer(
                        label: NSLocalizedString("humidity", comment: ""),
                        value: "\(weather.current.humidity) %",
                        icon: "humidity"
                    )
                    StatContainer(
                        label: NSLocalizedString("wind", comment: ""),
                        value: String(
                            format: NSLocalizedString("kph", comment: ""),
                            "\(weather.current.windKph)"
                        ),
                        icon: "wind"
                    )
                }

                HStack {
                    StatContainer(
                        label: NSLocalizedString("pressure", comment: ""),
                        value: String(
                            format: NSLocalizedString("Mb", comment: ""),
                            "\(weather.current.pressureMb)"
                        ),
                        icon: "rectangle.compress.vertical"
                    )
                    StatContainer(
                        label: NSLocalizedString("feels like", comment: ""),
                        value: "\(weather.current.feelslikeC)°С",
                        icon: "thermometer.transmission"
                    )
                }

                Spacer()
                    .frame(height: 16)
                HStack {
                    Image(systemName: "timer").foregroundStyle(Color("Secondary"))
                    Text("Updated \(viewModel.timerValue.format())")
                        .font(.default)
                        .foregroundStyle(Color("Secondary"))
                }
            }
            .padding(16).glassEffect(in: RoundedRectangle(cornerRadius: 30)).padding(24)
        }
    }
}

#Preview {
//    AnimatedGlassView()
}
