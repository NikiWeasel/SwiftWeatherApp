//
//  WeatherStatsUseCaseProtocol.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

protocol WeatherStatsUseCaseProtocol {
    func execute(city: String) async -> Result<WeatherEntity, AppError>
}
