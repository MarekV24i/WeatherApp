//
//  AppState.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

@MainActor
class AppState: ObservableObject {
    
    @Published var cities = [CityModel]()
    @Published var selectedCity: CityModel?
    @Published var conditions : [ConditionsModel]?
    
    init(cities: [CityModel] = [CityModel](), selectedCity: CityModel? = nil, conditions: [ConditionsModel]? = nil) {
        self.cities = cities
        self.selectedCity = selectedCity
        self.conditions = conditions
    }
}
