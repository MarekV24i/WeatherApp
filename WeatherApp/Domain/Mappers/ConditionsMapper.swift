//
//  ConditionsMapper.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

class ConditionsMapper {
    
    static func map(entity: ConditionsEntity) -> ConditionsModel {
        
        func getUnitsData(_ entity: ConditionsEntity.Units?) -> ConditionsModel.UnitsData? {
            return ConditionsModel.UnitsData(value: entity?.Metric?.Value, unit: entity?.Metric?.Unit )
        }
        
         return ConditionsModel(
            time: ISO8601DateFormatter().date(from: entity.LocalObservationDateTime ?? ""),
            text: entity.WeatherText,
            temperature: getUnitsData(entity.Temperature),
            feelsLike: getUnitsData(entity.ApparentTemperature),
            visibility: getUnitsData(entity.Visibility),
            precipitation: getUnitsData(entity.PrecipitationSummary?.Precipitation),
            link: entity.MobileLink
         )
    }
    
    
}

