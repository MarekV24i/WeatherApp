//
//  getConditions.swift
//  WeatherApp
//
//  Created by Marek on 15.10.2023.
//

import Foundation

protocol GetConditionsUseCaseProtocol {
    
    func execute(cityKey: String) throws
}

class GetConditionsUseCase: NetworkUseCase, GetConditionsUseCaseProtocol {

    @MainActor
    func execute(cityKey: String) throws {
        loadTask?.cancel()
                
        loadTask = Task {
            do {
                let entities = try await repository.currentCondtions(cityKey: cityKey)
                self.appState.conditions = entities.map {
                    ConditionsMapper.map(entity: $0)
                }
            }
            catch {
                throw AppError.conditionsLoadFailed
            }
        }
    }
}
