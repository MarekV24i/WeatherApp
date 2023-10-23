//
//  ConditionsEntity.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

// Server response for conditions load
struct ConditionsEntity: Codable {
    
    struct Units: Codable {
        var Metric: UnitsData?
    }
    
    struct UnitsData: Codable {
        var Value: Double?
        var Unit: String?
    }

    struct Precipitation: Codable {
        var Precipitation: Units?
    }
    
    var LocalObservationDateTime: String?
    var WeatherText: String?
    var Temperature: Units?
    var ApparentTemperature: Units?
    var Visibility: Units?
    var PrecipitationSummary: Precipitation?
    var MobileLink: String?
}
