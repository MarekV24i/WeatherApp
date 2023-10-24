//
//  CityModel.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// Model for City in Domain layer
struct CityModel: Equatable {

    var id = UUID()
    var key: String?
    var name: String?
    var country: String?

    init(key: String? = nil, name: String? = nil, country: String? = nil) {
        self.key = key
        self.name = name
        self.country = country
    }
}
