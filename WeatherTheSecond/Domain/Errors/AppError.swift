//
//  AppError.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 18.12.2025.
//

enum AppError: Error {
    case network(String)
    case server(Int)
    case parsing(String)
    case validation(String) // бизнес-ошибка
    case unknown
}
