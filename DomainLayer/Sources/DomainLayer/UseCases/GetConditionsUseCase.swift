//
//  getConditions.swift
//  WeatherApp
//
//  Created by Marek on 15.10.2023.
//

import Foundation

// UseCase for loading conditions
public protocol GetConditionsUseCaseProtocol {

    func execute(cityKey: String) async throws
}

class GetConditionsUseCase: NetworkUseCase, GetConditionsUseCaseProtocol {

    @MainActor
    func execute(cityKey: String) async throws {
        loadTask?.cancel()

        loadTask = Task {
            try Task.checkCancellation()
            self.appState.conditions = try await repository.currentCondtions(cityKey: cityKey)
        }

        do {
            try await loadTask?.value
        } catch {
            throw AppError.conditionsLoadFailed
        }
    }
}
