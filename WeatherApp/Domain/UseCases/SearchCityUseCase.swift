//
//  SearchCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

protocol SearchCityUseCaseProtocol {

    func execute(term: String) async throws
}

class SearchCityUseCase: SearchCityUseCaseProtocol {

    private let repository: NetworkRepository
    private let appState: AppState

    init(repository: NetworkRepository, appState: AppState) {
        self.repository = repository
        self.appState = appState
    }

    func execute(term: String) async throws {
        do {
            let entities = try await repository.searchCity(term: term)
            DispatchQueue.main.async {
                self.appState.cities = entities.map {
                    CityMapper.map(entity: $0)
                }
            }
        }
        catch {
            throw AppError.citySearchFailed
        }
    }
}
