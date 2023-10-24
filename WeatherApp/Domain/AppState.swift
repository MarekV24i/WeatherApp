//
//  AppState.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

// Single source of truth.
// Holds data and appliciiton state.
// Observed by Views - changed by UseCases

@MainActor
class AppState: ObservableObject {

    @Published var cities = [CityModel]()               // Cities found by search
    @Published var selectedCity: CityModel?             // City selected by user
    @Published var conditions: [ConditionsModel]?      // Conditions for selected city

    init(cities: [CityModel] = [CityModel](), selectedCity: CityModel? = nil, conditions: [ConditionsModel]? = nil) {
        self.cities = cities
        self.selectedCity = selectedCity
        self.conditions = conditions
    }
}
