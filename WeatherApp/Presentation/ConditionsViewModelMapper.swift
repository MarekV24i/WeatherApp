//
//  ConditionsViewModelMapper.swift
//  WeatherApp
//
//  Created by Marek on 16.10.2023.
//

import Foundation


class ConditionsViewModelMapper {
    
    static func map(model: ConditionsModel) -> ConditionsViewModel {
        
        let time = getTimeFormatted(model.time)
        let text = model.text ?? ""
        let temperature = getLabelFormatted(value: model.temperature?.value, unit: model.temperature?.unit, format: "%.1f °%@")
        let feelsLike = getLabelFormatted(value: model.feelsLike?.value, unit: model.feelsLike?.unit, format: "Feeels like %.1f °%@")
        let visibility = getLabelFormatted(value: model.visibility?.value, unit: model.visibility?.unit, format: "Visibility %.1f %@")
        let precipitaiton = getLabelFormatted(value: model.precipitation?.value, unit: model.precipitation?.unit, format:       "Precipitation %.1f %@")
        
        var link:URL?
        if let URLString = model.link {
            link = URL(string: URLString)
        }
        
        return ConditionsViewModel(time: time, text: text, temperature: temperature, feelsLike: feelsLike, visibility: visibility, precipitation: precipitaiton, link: link)
    }
    
    private static func getTimeFormatted(_ date: Date?) -> String {
        guard let time = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd.MM.yyyy"
        return formatter.string(from: time)
    }
    
    private static func getLabelFormatted(value: Double?, unit: String?, format: String) -> String {
        guard let value = value, let unit = unit else {
            return ""
        }
        return String(format: format, value, unit)
    }
    
    
}
