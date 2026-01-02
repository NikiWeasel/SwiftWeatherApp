//
//  APIError.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decoding(Error)
}
