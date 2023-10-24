//
//  getConditions.swift
//  WeatherApp
//
//  Created by Marek on 15.10.2023.
//

import Foundation

// UseCase for loading conditions
protocol GetConditionsUseCaseProtocol {
    
    func execute(cityKey: String) async throws
}

class GetConditionsUseCase: NetworkUseCase, GetConditionsUseCaseProtocol {

    @MainActor
    func execute(cityKey: String) async throws {
        loadTask?.cancel()
        
        loadTask = Task {
            let entities = try await repository.currentCondtions(cityKey: cityKey)
            try Task.checkCancellation()
            self.appState.conditions = entities.map {
                ConditionsMapper.map(entity: $0)
            }
        }
        
        do {
            try await loadTask?.value
        }
        catch {
            throw AppError.conditionsLoadFailed
        }
    }
}
