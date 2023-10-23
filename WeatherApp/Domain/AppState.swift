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


   
//    override init() {
//        super.init()
//        self.cities = [CityModel(key:"1234", name: "Brno", country: "Czechia"), CityModel(key:"4567", name: "Zlín", country: "Czechia")]
//        self.selectedCity = CityModel(key:"4567", name: "Zlín", country: "Czechia")
//    }
//}

