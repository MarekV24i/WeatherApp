//
//  SearchCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// UseCase for city seaching
protocol SearchCityUseCaseProtocol {

    func execute(term: String) async throws
}

class SearchCityUseCase: NetworkUseCase, SearchCityUseCaseProtocol {
    
    @MainActor
    func execute(term: String) async throws {
        loadTask?.cancel()
        
        loadTask = Task {
            let entities = try await repository.searchCity(term: term)
            try Task.checkCancellation()
            self.appState.cities = entities.map {
                CityMapper.map(entity: $0)
            }
        }
        
        do {
            try await loadTask?.value
        }
        catch is CancellationError {
            throw AppError.requestCancelled
        }
        catch {
            throw AppError.citySearchFailed
        }
    }
}
