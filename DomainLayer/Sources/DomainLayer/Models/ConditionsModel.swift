//
//  ConditionsModel.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// Model for Conditions in Domain layer
public struct ConditionsModel: Equatable {
    public static func == (lhs: ConditionsModel, rhs: ConditionsModel) -> Bool {
        lhs.time == rhs.time && lhs.text == rhs.text && lhs.link == rhs.link
    }

    public struct UnitsData {
        public var value: Double?
        public var unit: String?

        public init(value: Double? = nil, unit: String? = nil) {
            self.value = value
            self.unit = unit
        }
    }

    public var time: Date?
    public var text: String?
    public var temperature: UnitsData?
    public var feelsLike: UnitsData?
    public var visibility: UnitsData?
    public var precipitation: UnitsData?
    public var link: String?

    public init(
        time: Date? = nil,
        text: String? = nil,
        temperature: UnitsData? = nil,
        feelsLike: UnitsData? = nil,
        visibility: UnitsData? = nil,
        precipitation: UnitsData? = nil,
        link: String? = nil
    ) {
        self.time = time
        self.text = text
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.visibility = visibility
        self.precipitation = precipitation
        self.link = link
    }
}
