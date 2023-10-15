//
//  UseCases.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import SwiftUI

class UseCaseContainer: ObservableObject {
    let selectCity: SelectCityUseCaseProtocol
    let searchCity: SearchCityUseCaseProtocol
    let getConditions: GetConditionsUseCaseProtocol
    
    init(repository: NetworkRepository, appState: AppState) {
        self.selectCity = SelectCityUseCase(appState: appState)
        self.searchCity = SearchCityUseCase(repository: repository, appState: appState)
        self.getConditions = GetConditionsUseCase(repository: repository, appState: appState)
    }
}
