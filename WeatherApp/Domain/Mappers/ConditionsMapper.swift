//
//  ConditionsMapper.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

class ConditionsMapper {
    
    static func map(entity: ConditionsEntity) -> ConditionsModel {
        
        func getUnitsData(_ entity: ConditionsEntity.Units?) -> ConditionsModel.UnitsData? {
            return ConditionsModel.UnitsData(value: entity?.Metric?.Value, unit: entity?.Metric?.Unit )
        }
        
         return ConditionsModel(
            time: entity.LocalObservationDateTime,
            text: entity.WeatherText,
            temperature: getUnitsData(entity.Temperature),
            feelsLike: getUnitsData(entity.ApparentTemperature),
            visibility: getUnitsData(entity.Visibility),
            precipitation: getUnitsData(entity.PrecipitationSummary?.Precipitation),
            link: entity.MobileLink
         )
    }
    
}

