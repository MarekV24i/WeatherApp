//
//  Mockups.swift
//  WeatherApp
//
//  Created by Marek on 18.10.2023.
//

import Foundation

public class MockupSearchCityUseCase: NetworkUseCase, SearchCityUseCaseProtocol {

    @MainActor
    public func execute(term: String) throws {
        appState.cities = MockupData.mockCities + [CityModel()]
    }
}

public class MockupGetConditionsUseCase: NetworkUseCase, GetConditionsUseCaseProtocol {

    @MainActor
    public func execute(cityKey: String) throws {
        self.appState.conditions = [MockupData.mockConditions]
    }
}

public struct MockupData {
    public static let mockCities = [CityModel(
        key: "123",
        name: "Otrokovice",
        country: "Czechia"
    ),
                             CityModel(
                                key: "456",
                                name: "New York",
                                country: "USA"
                             )
    ]

    public static let mockConditions = ConditionsModel(
        time: Date(),
        text: "Very hot",
        temperature: ConditionsModel.UnitsData(value: 30.2, unit: "C"),
        feelsLike: ConditionsModel.UnitsData(value: 40.2, unit: "C"),
        visibility: ConditionsModel.UnitsData(value: 24, unit: "km"),
        precipitation: ConditionsModel.UnitsData(value: 0.4, unit: "mm"),
        link: "https://www.google.com"
    )
}

public struct MockupSelectCityUseCase: SelectCityUseCaseProtocol {

    private let appState: AppState

    public init(appState: AppState) {
        self.appState = appState
    }

    @MainActor
    public func execute(_ city: CityModel) {
        print("Selected city: \(city.name ?? "")")
        appState.selectedCity = MockupData.mockCities.first
    }
}

public class MockupNetworkRepository: NetworkRepositoryProtocol {
    public init() {}

    public func searchCity(term: String?) async throws -> [DomainLayer.CityModel] {
        []
    }

    public func currentCondtions(cityKey: String) async throws -> [DomainLayer.ConditionsModel] {
        []
    }
}
