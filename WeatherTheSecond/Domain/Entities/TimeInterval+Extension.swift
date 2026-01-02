//
//  TimeInterval+Extension.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 23.12.2025.
//

import Foundation

extension TimeInterval {
    func format() -> String {
        let value = self
        let minVal = Int(self) / 60
        switch value {
        case 0 ... 60:
            return NSLocalizedString("recently", comment: "")
        case 60 ... 120:
            return "\(minVal) \(NSLocalizedString("minute", comment: "")) \(NSLocalizedString("ago", comment: ""))"
        default:
            return "\(minVal) \(NSLocalizedString("minutes", comment: "")) \(NSLocalizedString("ago", comment: ""))"
        }
    }
}
