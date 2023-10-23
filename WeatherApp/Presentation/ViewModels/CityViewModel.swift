//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Marek on 18.10.2023.
//

import Foundation

// View model for City in Presentation layer
struct CityViewModel {
    
    var id = UUID()
    var key: String?
    var name: String = String(localized: "unknown_city")
    var country: String?
    
    //Formatted label to be presented in city list
    var label: String {
        guard let country = country else {
            return name
        }
        return name + " (\(country))"
    }
}
