//
//  UseCases.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import SwiftUI

// Holds all possible UseCases
class UseCaseContainer: ObservableObject {
    
    var selectCity: SelectCityUseCaseProtocol
    var searchCity: SearchCityUseCaseProtocol
    var getConditions: GetConditionsUseCaseProtocol
    
    init(repository: NetworkRepository, appState: AppState) {
        self.selectCity = SelectCityUseCase(appState: appState)
        self.searchCity = SearchCityUseCase(repository: repository, appState: appState)
        self.getConditions = GetConditionsUseCase(repository: repository, appState: appState)
    }
}
