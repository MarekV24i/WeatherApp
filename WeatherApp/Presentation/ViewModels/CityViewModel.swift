//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Marek on 18.10.2023.
//

import Foundation

struct CityViewModel {
    
    var id = UUID()
    var key: String?
    var name: String = "Unknown city"
    var country: String?
    
    var label: String {
        guard let country = country else {
            return name
        }
        return name + " (\(country))"
    }
}
