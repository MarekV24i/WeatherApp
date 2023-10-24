//
//  CityEntity.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

// Server response for city search
struct CityEntity: Codable {

    struct Country: Codable {
        var LocalizedName: String?
    }

    var Key: String?
    var LocalizedName: String?
    var Country: Country?
}
