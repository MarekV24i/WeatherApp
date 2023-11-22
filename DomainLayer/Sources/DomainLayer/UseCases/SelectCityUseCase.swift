//
//  SelectCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// UseCase for city selection
public protocol SelectCityUseCaseProtocol {

    func execute(_ city: CityModel)
}

struct SelectCityUseCase: SelectCityUseCaseProtocol {

    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    @MainActor
    func execute(_ city: CityModel) {
        self.appState.selectedCity = city
    }
}
