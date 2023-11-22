//
//  CityModel.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// Model for City in Domain layer
public struct CityModel: Equatable {

    public var id = UUID()
    public var key: String?
    public var name: String?
    public var country: String?

    public init(key: String? = nil, name: String? = nil, country: String? = nil) {
        self.key = key
        self.name = name
        self.country = country
    }
}
