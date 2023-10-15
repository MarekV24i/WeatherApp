//
//  AppState.swift
//  WeatherApp
//
//  Created by Marek on 13.10.2023.
//

import SwiftUI

class AppState: ObservableObject {
    //@Published var cities = [CityModel]()
    
    @Published var cities = [CityModel(key: "123291", name: "Brno"),
                             CityModel(key: "3394756", name: "Brno2"),
                             CityModel(key: "1379956", name: "Brnov")]
    
    @Published var selectedCity: CityModel?
    
    @Published var conditions = [ConditionsModel]()
                         

}
