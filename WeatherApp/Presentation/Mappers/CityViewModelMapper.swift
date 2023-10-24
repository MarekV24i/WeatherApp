//
//  CityViewModelMapper.swift
//  WeatherApp
//
//  Created by Marek on 18.10.2023.
//

// Mapping city data between Presentation and Domain layer
struct CityViewModelMapper {

    static func map(model: CityModel) -> CityViewModel {
        var city = CityViewModel()
        if let name = model.name {
            city.name = name
        }
        city.key = model.key
        city.country = model.country
        return city
    }

    static func map(viewModel: CityViewModel) -> CityModel {
        return CityModel(
            key: viewModel.key,
            name: viewModel.name,
            country: viewModel.country
        )
    }

}
