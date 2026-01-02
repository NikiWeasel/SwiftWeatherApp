//
//  SearchCityUseCaseProtocol.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

protocol SearchCityUseCaseProtocol {
    func execute(query: String) async -> Result<[CityEntity], AppError>
}
