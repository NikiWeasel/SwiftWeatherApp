//
//  WeatherFetching.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

protocol WeatherFetching {
    func fetchWeather(city: String) async -> Result<WeatherEntity, AppError>
    func searchCity(query: String) async -> Result<[CityEntity], AppError>
}
