//
//  UseCases.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import SwiftUI

// Holds all possible UseCases
public class UseCaseContainer: ObservableObject {

    public var selectCity: SelectCityUseCaseProtocol
    public var searchCity: SearchCityUseCaseProtocol
    public var getConditions: GetConditionsUseCaseProtocol

    // UseCases can be injected, otherwise use default implementation
    public init(repository: NetworkRepositoryProtocol,
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
