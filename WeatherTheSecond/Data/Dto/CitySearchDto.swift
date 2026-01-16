//
//  CitySearchDto.swift
//  WeatherMoscow
//
//  Created by Никита Вахрушев on 17.12.2025.
//

struct CitySearchDto: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}

extension CitySearchDto {
    nonisolated func toEntity(
    ) -> CityEntity {
        return CityEntity(
            id: id,
            name: name,
            region: region,
            country: country
        )
    }
}
