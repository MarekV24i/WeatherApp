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
    @Published var conditions = [ConditionsModel]()
}
