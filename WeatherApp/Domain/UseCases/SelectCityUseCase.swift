//
//  SelectCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

protocol SelectCityUseCaseProtocol {
    func execute(_ city: CityModel)
}

class SelectCityUseCase: SelectCityUseCaseProtocol {

    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func execute(_ city: CityModel) {
        appState.selectedCity = city
    }
}


