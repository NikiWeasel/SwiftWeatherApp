//
//  LocationDto.swift
//  WeatherMoscow
//
//  Created by Никита Вахрушев on 17.12.2025.
//

struct LocationDto: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tzId: String
    let localtimeEpoch: Int
    let localtime: String
}
