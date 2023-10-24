//
//  CityMapper.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

// Mapping city data between Network and Domain layer
struct CityMapper {

    static func map(entity: CityEntity) -> CityModel {
         return CityModel(
            key: entity.Key,
            name: entity.LocalizedName,
            country: entity.Country?.LocalizedName
         )
    }
}
