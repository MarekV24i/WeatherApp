//
//  ConditionsModel.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

struct ConditionsModel {
    
    struct UnitsData {
        var value: Double?
        var unit: String?
    }

    var time: String?
    var text: String?
    var temperature: UnitsData?
    var feelsLike: UnitsData?
    var visibility: UnitsData?
    var precipitation: UnitsData?
    var link: String?
}

