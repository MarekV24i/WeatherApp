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

    // UseCases can be injected, otherwise use default implementation
    init(repository: NetworkRepository,
         appState: AppState,
         selectCity: SelectCityUseCaseProtocol? = nil,
         searchCity: SearchCityUseCaseProtocol? = nil,
         getConditions: GetConditionsUseCaseProtocol? = nil
    ) {
        self.selectCity = selectCity ?? SelectCityUseCase(appState: appState)
        self.searchCity = searchCity ?? SearchCityUseCase(repository: repository, appState: appState)
        self.getConditions = getConditions ?? GetConditionsUseCase(repository: repository, appState: appState)
    }
}
