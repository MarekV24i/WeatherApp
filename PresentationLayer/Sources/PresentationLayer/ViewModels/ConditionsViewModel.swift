//
//  ConditionsViewModel.swift
//  WeatherApp
//
//  Created by Marek on 16.10.2023.
//

import Foundation

// View model for Conditions in Presentation layer
struct ConditionsViewModel {

    var time: String = ""
    var text: String = ""
    var temperature: String = ""
    var feelsLike: String = ""
    var visibility: String = ""
    var precipitation: String = ""
    var link: URL?
}
