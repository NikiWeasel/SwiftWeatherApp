//
//  StatContainer.swift
//  WeatherTheSecond
//
//  Created by Никита Вахрушев on 20.12.2025.
//

import SwiftUI

struct StatContainer: View {
    var label: String
    var value: String
    var icon: String

    var body: some View {
        VStack {
            HStack {
                Image(
                    systemName: icon
                )
                .foregroundStyle(Color("Secondary"))
                Text(label)
                    .font(.default).foregroundStyle(Color("Secondary"))
            }
            Text(value)
                .font(.subheadline)
        }.frame(maxWidth: .infinity)
            .padding().glassEffect(
                .regular.tint(.white),
                in: RoundedRectangle(cornerRadius: 20)
            )
    }
}
