//
//  ConditionsModel.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// Model for Conditions in Domain layer
struct ConditionsModel: Equatable {
    static func == (lhs: ConditionsModel, rhs: ConditionsModel) -> Bool {
        lhs.time == rhs.time && lhs.text == rhs.text && lhs.link == rhs.link
    }
    
    struct UnitsData {
        var value: Double?
        var unit: String?
    }

    var time: Date?
    var text: String?
    var temperature: UnitsData?
    var feelsLike: UnitsData?
    var visibility: UnitsData?
    var precipitation: UnitsData?
    var link: String?
}

