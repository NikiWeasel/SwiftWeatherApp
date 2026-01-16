//
//  WeatherResponseDto.swift
//  WeatherMoscow
//
//  Created by Никита Вахрушев on 17.12.2025.
//

nonisolated struct WeatherResponseDto: Codable, Sendable {
    let location: LocationDto
    let current: CurrentWeatherDto
}

extension WeatherResponseDto {
    nonisolated func toEntity() -> WeatherEntity {
        return WeatherEntity(
            location: LocationEntity(
                name: location.name,
                region: location.region,
                country: location.country
            ),
            current: CurrentWeatherEntity(
                lastUpdatedEpoch: current.lastUpdatedEpoch,
                lastUpdated: current.lastUpdated,
                tempC: current.tempC,
                tempF: current.tempF,
                isDay: current.isDay,
                conditionText: current.condition.text,
                conditionIcon: "https:\(current.condition.icon)",
                windMph: current.windMph,
                windKph: current.windKph,
                windDegree: current.windDegree,
                windDir: current.windDir,
                pressureMb: current.pressureMb,
                pressureIn: current.pressureIn,
                precipMm: current.precipMm,
                precipIn: current.precipIn,
                humidity: current.humidity,
                cloud: current.cloud,
                feelslikeC: current.feelslikeC,
                feelslikeF: current.feelslikeF,
                windchillC: current.windchillC,
                windchillF: current.windchillF,
                heatindexC: current.heatindexC,
                heatindexF: current.heatindexF,
                dewpointC: current.dewpointC,
                dewpointF: current.dewpointF,
                visKm: current.visKm,
                visMiles: current.visMiles,
                uv: current.uv,
                gustMph: current.gustMph,
                gustKph: current.gustKph,
                shortRad: current.shortRad,
                diffRad: current.diffRad,
                dni: current.dni,
                gti: current.gti
            )
        )
    }
}
