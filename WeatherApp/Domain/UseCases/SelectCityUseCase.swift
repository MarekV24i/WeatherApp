//
//  SelectCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

protocol SelectCityUseCaseProtocol {
    
    func execute(_ city: CityModel)
}

class SelectCityUseCase: SelectCityUseCaseProtocol {

    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func execute(_ city: CityModel) {
        DispatchQueue.main.async {
            self.appState.selectedCity = city
        }
    }
}


