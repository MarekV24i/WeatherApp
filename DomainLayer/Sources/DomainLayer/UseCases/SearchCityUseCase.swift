//
//  SearchCityUseCase.swift
//  WeatherApp
//
//  Created by Marek on 14.10.2023.
//

import Foundation

// UseCase for city seaching
public protocol SearchCityUseCaseProtocol {

    func execute(term: String) async throws
}

class SearchCityUseCase: NetworkUseCase, SearchCityUseCaseProtocol {

    @MainActor
    func execute(term: String) async throws {
        loadTask?.cancel()

        loadTask = Task {
            try Task.checkCancellation()
            self.appState.cities = try await repository.searchCity(term: term)
        }

        do {
            try await loadTask?.value
        } catch is CancellationError {
            throw AppError.requestCancelled
        } catch {
            throw AppError.citySearchFailed
        }
    }
}
