//
//  RestRepository.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

import Foundation

actor RestRepository: WeatherFetching {
    private let service: WeatherProviding
    private let apiKey: String

    init(service: WeatherProviding, apiKey: String) {
        self.service = service
        self.apiKey = apiKey
    }

    func fetchWeather(city: String) async -> Result<WeatherEntity, AppError> {
        do {
            let dto = try await service.fetchWeather(key: apiKey, city: city, lang: "en")
            let entity = dto.toEntity()
            return .success(entity)
        } catch let error as APIError {
            let appError: AppError
            switch error {
            case .invalidURL:
                appError = .network("Invalid URL")
            case .invalidResponse:
                appError = .network("Invalid Response")
            case let .httpError(code):
                appError = .server(code)
            case let .decoding(decodeError):
                print(decodeError.localizedDescription)
                appError = .parsing(decodeError.localizedDescription)
            }
            return .failure(appError)
        } catch {
            return .failure(.unknown)
        }
    }

    func searchCity(query: String) async -> Result<[CityEntity], AppError> {
        do {
            let dtoList = try await service.searchCity(key: apiKey, cityQuery: query)
            let entities = dtoList.map { $0.toEntity() }
            return .success(entities)
        } catch let error as APIError {
            let appError: AppError
            switch error {
            case .invalidURL:
                appError = .network("Invalid URL")
            case .invalidResponse:
                appError = .network("Invalid Response")
            case let .httpError(code):
                appError = .server(code)
            case let .decoding(decodeError):
                appError = .parsing(decodeError.localizedDescription)
            }
            return .failure(appError)
        } catch {
            return .failure(.unknown)
        }
    }
}
